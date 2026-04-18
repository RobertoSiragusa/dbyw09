/**
 * Copyright (C) Fourier Semiconductor Inc. 2016-2020. All rights reserved.
 * 2020-08-20 File created.
 */

#include "fsm_public.h"
#include "fsm_q6afe.h"


#ifdef CONFIG_FSM_Q6AFE
static struct fsm_resp_params fsm_resp = { 0 };
//static atomic_t fsm_afe_state;
struct rtac_cal_block_data g_fsm_rtac_block;
static int fsm_rx_port = FSM_RX_PORT;
static int fsm_tx_port = FSM_TX_PORT;
static int g_fsm_re25[FSM_DEV_MAX] = { 0 };
struct mutex fsm_q6afe_lock;
static atomic_t fsm_vi_fb_switch;
#ifdef FSM_RUNIN_TEST
static atomic_t fsm_module_switch;
static atomic_t fsm_runin_test;

static int fsm_afe_test_ctrl(int index)
{
    struct fsm_afe afe;
    fsm_config_t *cfg;
    int runin_test;
    int ret;

    switch (index) {
        case FSM_TC_DISABLE_ALL:
            runin_test = 0; // disable all
            break;
        case FSM_TC_DISABLE_EQ:
            runin_test = 3; // disable eq only
            break;
        case FSM_TC_DISABLE_PROT:
            runin_test = 5; // disable protection only
            break;
        case FSM_TC_ENABLE_ALL:
        default:
            runin_test = 1; // enable all
            break;
    }
    cfg = fsm_get_config();
    pr_info("spkon:%d, testcase: %d", cfg->speaker_on, runin_test);
    if (!cfg->speaker_on) {
        atomic_set(&fsm_runin_test, index);
        return 0;
    }
    afe.module_id = AFE_MODULE_ID_FSADSP_RX;
    afe.port_id = fsm_afe_get_rx_port();
    afe.param_id  = CAPI_V2_PARAM_FSADSP_MODULE_ENABLE;
    afe.op_set = true;
    ret = fsm_afe_send_apr(&afe, &runin_test, sizeof(runin_test));
    if (ret) {
        pr_err("send apr failed:%d", ret);
        return ret;
    }
    atomic_set(&fsm_runin_test, index);

    return ret;
}

static int fsm_afe_module_ctrl(int index)
{
    struct fsm_afe afe;
    int enable;
    int ret;

    afe.module_id = AFE_MODULE_ID_FSADSP_TX;
    afe.port_id = fsm_tx_port;
    afe.param_id  = CAPI_V2_PARAM_FSADSP_TX_ENABLE;
    afe.op_set = true;
    enable = !!index;
    ret = fsm_afe_send_apr(&afe, &enable, sizeof(enable));
    if (ret) {
        pr_err("send apr failed:%d", ret);
        return ret;
    }
    // fsm_delay_ms(50);
    afe.module_id = AFE_MODULE_ID_FSADSP_RX;
    afe.port_id = fsm_rx_port;
    afe.param_id  = CAPI_V2_PARAM_FSADSP_RX_ENABLE;
    afe.op_set = true;
    enable = !!index;
    ret = fsm_afe_send_apr(&afe, &enable, sizeof(enable));
    if (ret) {
        pr_err("send apr failed:%d", ret);
        return ret;
    }
    atomic_set(&fsm_module_switch, index);
    ret = fsm_afe_test_ctrl(atomic_read(&fsm_runin_test));
    if (ret) {
        pr_err("test ctrl failed:%d", ret);
        return ret;
    }

    return ret;
}
#endif

int fsm_afe_get_rx_port(void)
{
    return fsm_rx_port;
}

int fsm_afe_get_tx_port(void)
{
    return fsm_tx_port;
}

int fsm_afe_callback_local(int opcode, void *payload, int size)
{
    uint32_t *payload32 = payload;
    uint8_t *buf8;
    int hdr_size;

    if (payload32[1] != AFE_MODULE_ID_FSADSP_RX
        && payload32[1] != AFE_MODULE_ID_FSADSP_TX) {
        return -EINVAL;
    }
    pr_debug("opcode:%x, status:%d, size:%d", opcode, payload32[0], size);
    if (fsm_resp.params == NULL || fsm_resp.size == 0) {
        pr_err("invalid fsm resp data");
        return 0;
    }
    if (payload32[0] != 0) {
        pr_err("invalid status: %d", payload32[0]);
        return 0;
    }
    // payload structure:
    // status32
    // param header v1/v3
    // param data
    switch (opcode) {
    case AFE_PORT_CMDRSP_GET_PARAM_V2:
        hdr_size = sizeof(uint32_t) + sizeof(struct param_hdr_v1);
        buf8 = (uint8_t *)payload + hdr_size;
        if (size - hdr_size < fsm_resp.size) {
            fsm_resp.size = size - hdr_size;
        }
        memcpy(fsm_resp.params, buf8, fsm_resp.size);
        break;
#ifdef FSM_PARAM_HDR_V3
    case AFE_PORT_CMDRSP_GET_PARAM_V3:
        hdr_size = sizeof(uint32_t) + sizeof(struct param_hdr_v3);
        buf8 = (uint8_t *)payload + hdr_size;
        if (size - hdr_size < fsm_resp.size) {
            fsm_resp.size = size - hdr_size;
        }
        memcpy(fsm_resp.params, buf8, fsm_resp.size);
        break;
#endif
    default:
        pr_err("invalid opcode:%x", opcode);
        return 0;
    }

    return 0;
}

static int fsm_afe_send_inband(struct fsm_afe *afe, void *buf, uint32_t length)
{
    int ret;

    pr_debug("port:%x, module:%x, param:0x%x, length:%d",
            afe->port_id, afe->module_id, afe->param_id, length);

    mutex_lock(&fsm_q6afe_lock);
    memset(&afe->param_hdr, 0, sizeof(afe->param_hdr));
    afe->param_hdr.module_id = afe->module_id;
#ifdef FSM_PARAM_HDR_V3
    afe->param_hdr.instance_id = INSTANCE_ID_0;
#endif
    afe->param_hdr.param_id = afe->param_id;
    afe->param_hdr.param_size = length;
    if (!afe->op_set) {
        fsm_afe_set_callback(fsm_afe_callback_local);
        fsm_resp.params = kzalloc(length, GFP_KERNEL);
        if (!fsm_resp.params) {
            pr_err("%s: Memory allocation failed!\n", __func__);
            ret = -ENOMEM;
            goto exit;
        }
        fsm_resp.size = length;
    }
    ret = q6afe_send_fsm_pkt(afe, buf, length);
    if (ret) {
        pr_err("sent packet for port %d failed with code %d",
                afe->port_id, ret);
        goto exit;
    }
    pr_debug("sent packet with param id 0x%08x to module 0x%08x",
            afe->param_id, afe->module_id);
    if (!afe->op_set) {
        memcpy(buf, fsm_resp.params, fsm_resp.size);
        afe->param_size = fsm_resp.size;
    }
exit:
    if (fsm_resp.params) {
        kfree(fsm_resp.params);
        fsm_resp.params = NULL;
        fsm_resp.size = 0;
    }
    mutex_unlock(&fsm_q6afe_lock);

    return ret;
}

static int fsm_afe_map_rtac_block(struct rtac_cal_block_data *fsm_cal)
{
    size_t len;
    int ret;

    if (fsm_cal == NULL)
        return -EINVAL;
#ifdef FSM_PARAM_HDR_V3
    if (fsm_cal->map_data.dma_buf == NULL) {
        fsm_cal->map_data.map_size = SZ_4K;
        ret = msm_audio_ion_alloc(&(fsm_cal->map_data.dma_buf),
                fsm_cal->map_data.map_size,
                &(fsm_cal->cal_data.paddr), &len,
                &(fsm_cal->cal_data.kvaddr));
        if (ret < 0) {
            pr_err("%s: allocate buffer failed! ret = %d\n", __func__, ret);
            return ret;
        }
    }
#else
    if (fsm_cal->map_data.ion_handle == NULL) {
        fsm_cal->map_data.map_size = SZ_4K;
        ret = msm_audio_ion_alloc("fsm_cal", &(fsm_cal->map_data.ion_client),
                &(fsm_cal->map_data.ion_handle), fsm_cal->map_data.map_size,
                &(fsm_cal->cal_data.paddr), &len,
                &(fsm_cal->cal_data.kvaddr));
        if (ret < 0) {
            pr_err("%s: allocate buffer failed! ret = %d\n", __func__, ret);
            return ret;
        }
    }
#endif
    if (fsm_cal->map_data.map_handle == 0) {
        ret = afe_map_rtac_block(fsm_cal);
        if (ret < 0) {
            pr_err("%s: map buffer failed! ret = %d\n", __func__, ret);
            return ret;
        }
    }

    return 0;
}


static int fsm_afe_ummap_rtac_block(struct rtac_cal_block_data *fsm_cal)
{
    int ret;

    if (fsm_cal == NULL)
        return 0;
    ret = afe_unmap_rtac_block(&fsm_cal->map_data.map_handle);
    if (ret < 0) {
        pr_err("%s: unmap buffer failed! ret = %d\n", __func__, ret);
        return ret;
    }

    return ret;
}

int fsm_afe_send_apr(struct fsm_afe *afe, void *buf, uint32_t length)
{
    struct rtac_cal_block_data *cal_data;
    uint32_t *ptr_data;
    int ret;

    pr_info("port:%x, module:%x, param:0x%x, length:%d",
            afe->port_id, afe->module_id, afe->param_id, length);
    if (length < APR_CHUNK_SIZE) {
        return fsm_afe_send_inband(afe, buf, length);
    }
    mutex_lock(&fsm_q6afe_lock);
    afe->cal_block = &g_fsm_rtac_block;
    cal_data = afe->cal_block;
    ret = fsm_afe_map_rtac_block(afe->cal_block);
    if (ret) {
        pr_err("map rtac block failed:%d", ret);
        mutex_unlock(&fsm_q6afe_lock);
        return -ENOMEM;
    }
    memset(&afe->param_hdr, 0, sizeof(afe->param_hdr));
    memset(&fsm_resp, 0, sizeof(fsm_resp));
    afe->param_hdr.module_id = afe->module_id;
#ifdef FSM_PARAM_HDR_V3
    afe->param_hdr.instance_id = INSTANCE_ID_0;
#endif
    afe->param_hdr.param_id = afe->param_id;
    afe->param_hdr.param_size = length;
    memset(&afe->mem_hdr, 0, sizeof(struct mem_mapping_hdr));
    afe->mem_hdr.data_payload_addr_lsw =
            lower_32_bits(cal_data->cal_data.paddr);
    afe->mem_hdr.data_payload_addr_msw =
            msm_audio_populate_upper_32_bits(cal_data->cal_data.paddr);
    afe->mem_hdr.mem_map_handle = cal_data->map_data.map_handle;
    if (!afe->op_set) {
        fsm_afe_set_callback(fsm_afe_callback_local);
        fsm_resp.params = kzalloc(length, GFP_KERNEL);
        if (!fsm_resp.params) {
            pr_err("%s: Memory allocation failed!\n", __func__);
            goto exit;
        }
        fsm_resp.size = length;
    }
    ptr_data = (uint32_t *)buf;
    ret = q6afe_send_fsm_pkt(afe, buf, length);
    if (ret) {
        pr_err("sent packet for port %d failed with code %d",
                afe->port_id, ret);
        goto exit;
    }
    pr_debug("sent packet with param 0x%08x to module 0x%08x",
            afe->param_id, afe->module_id);
    if (!afe->op_set) {
        memcpy(buf, fsm_resp.params, fsm_resp.size);
        afe->param_size = fsm_resp.size;
    }
exit:
    if (fsm_resp.params) {
        kfree(fsm_resp.params);
        fsm_resp.params = NULL;
        fsm_resp.size = 0;
    }
    fsm_afe_ummap_rtac_block(afe->cal_block);
    mutex_unlock(&fsm_q6afe_lock);

    return ret;
}

int fsm_afe_read_re25(char *fname, int *re25)
{
    char buf[STRING_LEN_MAX] = {0};
    struct file *fp;
    long data = 0;
    // mm_segment_t fs;
    loff_t pos = 0;
    int result;

    // fs = get_fs();
    // set_fs(get_ds());
    fp = filp_open(fname, O_RDONLY, 0664);
    if (IS_ERR(fp)) {
        pr_err("open %s failed", fname);
        // set_fs(fs);
        return -EINVAL;
    }
    // vfs_read(fp, buf, STRING_LEN_MAX - 1, &pos);
#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0))
    result = kernel_read(fp, pos, buf, STRING_LEN_MAX - 1);
#else
    result = kernel_read(fp, buf, STRING_LEN_MAX - 1, &pos);
#endif
    filp_close(fp, NULL);
    if (result <= 0) {
        pr_err("read read fail:%d", result);
        return -EINVAL;
    }
    result = kstrtol(buf, 10, &data);
    if (result) {
        pr_err("parse re25 fail:%d", result);
    }
    // set_fs(fs);
    if (re25) {
        *re25 = (int)data;
    }

    return result;
}

int fsm_afe_write_re25(char *name, int re25)
{
    char buf[STRING_LEN_MAX] = {0};
    struct file *fp;
    // mm_segment_t fs;
    loff_t pos = 0;
    int result;
    int len = 0;

    // fs = get_fs();
    // set_fs(get_ds());
    fp = filp_open(name, O_RDWR | O_CREAT, 0664);
    if (IS_ERR(fp)) {
        pr_err("open %s failed", name);
        // set_fs(fs);
        return PTR_ERR(fp);
    }
    pr_info("save file:%s, re25: %d", name, re25);
    len = snprintf(buf, STRING_LEN_MAX, "%d", re25);
    if (len <= 0) {
        filp_close(fp, NULL);
        return -EINVAL;
    }
    // vfs_write(fp, buf, len, &pos);
#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0))
    result = kernel_write(fp, buf, len, pos);
#else
    result = kernel_write(fp, buf, len, &pos);
#endif
    if (result != len) {
        pr_err("write file fail:%d, len:%d", result, len);
        filp_close(fp, NULL);
        return -ENOMEM;
    }
    filp_close(fp, NULL);
    // set_fs(fs);

    return 0;
}

int fsm_afe_save_re25(struct fsadsp_cmd_re25 *cmd_re25)
{
    fsm_config_t *cfg = fsm_get_config();
    int payload[FSM_PAYLOAD_SIZE];
    char fname[STRING_LEN_MAX];
    fsm_dev_t *fsm_dev;
    struct fsm_afe afe;
    int len = 0;
    int re25;
    int dev;
    int ret;

    memset(cmd_re25, 0, sizeof(struct fsadsp_cmd_re25));
    afe.module_id = AFE_MODULE_ID_FSADSP_RX;
    afe.port_id = fsm_afe_get_rx_port();
    afe.param_id  = CAPI_V2_PARAM_FSADSP_CALIB;
    afe.op_set = false;
    ret = fsm_afe_send_apr(&afe, payload, sizeof(payload));
    if (ret) {
        pr_err("send apr failed:%d", ret);
        return ret;
    }
    fsm_reset_re25_data();
    for (dev = 0; dev < cfg->dev_count; dev++) {
        fsm_dev = fsm_get_fsm_dev_by_id(dev);
        if (fsm_dev == NULL || fsm_skip_device(fsm_dev)) {
            continue;
        }
        cmd_re25->cal_data[cmd_re25->ndev].channel = fsm_dev->pos_mask;
        len = snprintf(fname, STRING_LEN_MAX, "%s/fsm_cal_%02X.bin",
                FSM_CALIB_SAVE_PATH, fsm_dev->pos_mask);
        if (len <= 0) {
            ret |= -EINVAL;
        }
        if ((fsm_dev->pos_mask & 0x3) == 0) { // left or mono
            re25 = payload[0]; // left or mono
        } else {
            re25 = payload[6]; // right
        }
        cmd_re25->cal_data[cmd_re25->ndev].re25 = re25;
        ret |= fsm_afe_write_re25(fname, re25);
        cmd_re25->ndev++;
    }

    return ret;
}

int fsm_afe_mod_ctrl(bool enable)
{
    fsm_config_t *cfg = fsm_get_config();
    struct fsadsp_cmd_re25 *params;
    struct fsm_afe afe;
    fsm_dev_t *fsm_dev;
    int param_size;
    int index;
    int dev;
    int ret;

    if (!enable || cfg->dev_count == 0) {
        return 0;
    }
    param_size = sizeof(struct fsadsp_cmd_re25);
    // + cfg->dev_count * sizeof(struct fsadsp_cal_data);
    params = (struct fsadsp_cmd_re25 *)fsm_alloc_mem(param_size);
    if (params == NULL) {
        pr_err("allocate memory failed");
        return -EINVAL;
    }
    memset(params, 0, param_size);
    params->version = FSADSP_RE25_CMD_VERSION_V1;
    params->ndev = cfg->dev_count;
    for (dev = 0; dev < cfg->dev_count; dev++) {
        fsm_dev = fsm_get_fsm_dev_by_id(dev);
        if (fsm_dev == NULL || fsm_skip_device(fsm_dev))
            continue;
        if (fsm_dev->pos_mask == 0 || (fsm_dev->pos_mask & 0xC) != 0) {
            index = 0; // mono/left
        } else {
            index = 1; // right
        }
        params->cal_data[index].rstrim = LOW8(fsm_dev->rstrim);
        params->cal_data[index].channel = fsm_dev->pos_mask;
        pr_info("re25[%X]:%d", fsm_dev->pos_mask, g_fsm_re25[dev]);
        if (g_fsm_re25[dev] != 0) {
            // set re25 from hal layer
            params->cal_data[index].re25 = g_fsm_re25[dev];
            continue;
        } else {
            params->cal_data[index].re25 = 0;
            pr_err("re25[%X]:%d", fsm_dev->pos_mask, g_fsm_re25[dev]);
            continue;
        }
    }
    afe.module_id = AFE_MODULE_ID_FSADSP_RX;
    afe.port_id = fsm_afe_get_rx_port();
    afe.param_id  = CAPI_V2_PARAM_FSADSP_RE25;
    afe.op_set = true;
    ret = fsm_afe_send_apr(&afe, params, param_size);
    fsm_free_mem((void **)&params);
    if (ret) {
        pr_err("send re25 failed:%d", ret);
        return ret;
    }
#ifdef FSM_RUNIN_TEST
    ret = fsm_afe_test_ctrl(atomic_read(&fsm_runin_test));
    if (ret) {
        pr_err("test ctrl failed:%d", ret);
        return ret;
    }
#endif

    return ret;
}

void fsm_reset_re25_data(void)
{
    memset(g_fsm_re25, 0, sizeof(g_fsm_re25));
}

int fsm_set_re25_data(struct fsm_re25_data *data)
{
    fsm_config_t *cfg = fsm_get_config();
    fsm_dev_t *fsm_dev;
    int ret = 0;
    int dev;

    if (cfg == NULL || data == NULL) {
        return -EINVAL;
    }
    fsm_reset_re25_data();
    if (data->count <= 0) {
        pr_err("invalid dev count");
        return -EINVAL;
    } else if (data->count == 1) { // mono
        g_fsm_re25[0] = data->re25[0];
    } else {
        for (dev = 0; dev < data->count; dev++) {
            fsm_dev = fsm_get_fsm_dev_by_id(dev);
            if (fsm_dev == NULL || fsm_skip_device(fsm_dev))
                continue;
            if ((fsm_dev->pos_mask & 0x0C) != 0) { // left mask
                g_fsm_re25[dev] = data->re25[0];
            } else { // right mask
                g_fsm_re25[dev] = data->re25[1];
            }
        }
    }
    if (cfg->speaker_on) {
        ret = fsm_afe_mod_ctrl(true);
        if (ret) {
            pr_err("update re25 failed:%d", ret);
        }
    }

    return ret;
}

int fsm_afe_get_livedata(void *ldata, int size)
{
    struct fsm_afe afe;
    int ret;

    if (ldata == NULL) {
        return -EINVAL;
    }
    memset(g_fsm_re25, 0 , sizeof(g_fsm_re25));
    afe.module_id = AFE_MODULE_ID_FSADSP_RX;
    afe.port_id = fsm_afe_get_rx_port();
    afe.param_id  = CAPI_V2_PARAM_FSADSP_LIVEDATA;
    afe.op_set = false;
    ret = fsm_afe_send_apr(&afe, ldata, size);
    if (ret) {
        pr_err("send apr failed:%d", ret);
    }
    return ret;
}

int fsm_afe_send_preset(char *preset)
{
    const struct firmware *firmware;
    struct device *dev;
    struct fsm_afe afe;
    int ret;

    if ((dev = fsm_get_pdev()) == NULL) {
        pr_err("bad dev parameter");
        return -EINVAL;
    }
    ret = request_firmware(&firmware, preset, dev);
    if (ret) {
        pr_err("request firmware failed");
        return ret;
    }
    if (firmware->data == NULL && firmware->size <= 0) {
        pr_err("can't read firmware");
        return -EINVAL;
    }
    pr_debug("sending rx %s", preset);
    afe.module_id = AFE_MODULE_ID_FSADSP_RX;
    afe.port_id = fsm_afe_get_rx_port();
    afe.param_id  = CAPI_V2_PARAM_FSADSP_MODULE_PARAM;
    afe.op_set = true;
    ret = fsm_afe_send_apr(&afe, (void *)firmware->data,
            (uint32_t)firmware->size);
    if (ret) {
        pr_err("send apr failed:%d", ret);
    }
    release_firmware(firmware);

    return ret;
}

static int fsm_afe_rx_port_set(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
    int rx_port = ucontrol->value.integer.value[0];

    if ((rx_port < 0) || (rx_port > AFE_PORT_ID_INVALID)) {
        pr_err("out of range (%d)", rx_port);
        return 0;
    }

    pr_debug("change from %d to %d", fsm_rx_port, rx_port);
    fsm_rx_port = rx_port;

    return 0;
}

static int fsm_afe_rx_port_get(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
    ucontrol->value.integer.value[0] = fsm_rx_port;
    pr_debug("get rx port:%d", fsm_rx_port);

    return 0;
}

static int fsm_afe_tx_port_set(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
    int tx_port = ucontrol->value.integer.value[0];

    if ((tx_port < 0) || (tx_port > AFE_PORT_ID_INVALID)) {
        pr_err("out of range (%d)", tx_port);
        return 0;
    }

    pr_debug("change from %d to %d", fsm_tx_port, tx_port);
    fsm_tx_port = tx_port;

    return 0;
}

static int fsm_afe_tx_port_get(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
    ucontrol->value.integer.value[0] = fsm_tx_port;
    pr_debug("get tx port:%d", fsm_tx_port);

    return 0;
}

static const char *fsm_afe_switch_text[] = {
    "Off", "On"
};

static const struct soc_enum fsm_afe_switch_enum[] = {
    SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(fsm_afe_switch_text),
            fsm_afe_switch_text)
};

static int fsm_afe_vi_fb_switch_get(struct snd_kcontrol *pKcontrol,
                struct snd_ctl_elem_value *pUcontrol)
{
    int index = atomic_read(&fsm_vi_fb_switch);

    pUcontrol->value.integer.value[0] = index;
    pr_info("Switch %s", fsm_afe_switch_text[index]);

    return 0;
}

static int fsm_afe_vi_fb_switch_set(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    int index = ucontrol->value.integer.value[0];
    int port_tx;
    int port_rx;

    pr_info("Switch %s", fsm_afe_switch_text[index]);
    if (index) {
        port_tx = q6audio_get_port_id(fsm_tx_port);
        port_rx = q6audio_get_port_id(fsm_rx_port);
        afe_spk_prot_feed_back_cfg(port_tx, port_rx, 1, 0, 1);
    } else {
        afe_spk_prot_feed_back_cfg(0, 0, 0, 0, 0);
    }
    atomic_set(&fsm_vi_fb_switch, index);

    return 0;
}

#ifdef FSM_RUNIN_TEST
static int fsm_afe_module_switch_get(struct snd_kcontrol *pKcontrol,
                struct snd_ctl_elem_value *pUcontrol)
{
    int index = atomic_read(&fsm_module_switch);

    pUcontrol->value.integer.value[0] = index;
    pr_info("Switch %s", fsm_afe_switch_text[index]);

    return 0;
}

static int fsm_afe_module_switch_set(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    int index = ucontrol->value.integer.value[0];
    int ret;

    pr_info("Switch %s", fsm_afe_switch_text[index]);
    ret = fsm_afe_module_ctrl(index);
    if (ret) {
        pr_err("module ctrl failed:%d", ret);
        return ret;
    }

    return 0;
}

static int fsm_afe_runin_test_get(struct snd_kcontrol *pKcontrol,
                struct snd_ctl_elem_value *pUcontrol)
{
    int index = atomic_read(&fsm_runin_test);

    pUcontrol->value.integer.value[0] = index;
    pr_info("case: %d", index);

    return 0;
}

static int fsm_afe_runin_test_set(struct snd_kcontrol *kcontrol,
                struct snd_ctl_elem_value *ucontrol)
{
    int index = ucontrol->value.integer.value[0];
    int ret;

    pr_info("case: %d", index);
    ret = fsm_afe_test_ctrl(index);
    if (ret) {
        pr_err("test ctrl failed:%d", ret);
        return ret;
    }

    return 0;
}
#endif

static const struct snd_kcontrol_new fsm_afe_controls[] = {
    SOC_SINGLE_EXT("FSM_RX_Port", SND_SOC_NOPM, 0, AFE_PORT_ID_INVALID, 0,
            fsm_afe_rx_port_get, fsm_afe_rx_port_set),
    SOC_SINGLE_EXT("FSM_TX_Port", SND_SOC_NOPM, 0, AFE_PORT_ID_INVALID, 0,
            fsm_afe_tx_port_get, fsm_afe_tx_port_set),
    SOC_ENUM_EXT("FSM_VI_FB_Switch", fsm_afe_switch_enum[0],
            fsm_afe_vi_fb_switch_get, fsm_afe_vi_fb_switch_set),
#ifdef FSM_RUNIN_TEST
    SOC_ENUM_EXT("FSM_Module_Switch", fsm_afe_switch_enum[0],
            fsm_afe_module_switch_get, fsm_afe_module_switch_set),
    SOC_SINGLE_EXT("FSM_Runin_Test", SND_SOC_NOPM, 0, FSM_TC_MAX, 0,
            fsm_afe_runin_test_get, fsm_afe_runin_test_set),
#endif
};

void fsm_afe_init_controls(struct snd_soc_codec *codec)
{
    mutex_init(&fsm_q6afe_lock);
    memset(&g_fsm_rtac_block, 0, sizeof(struct rtac_cal_block_data));
    atomic_set(&fsm_vi_fb_switch, 0);
#ifdef FSM_RUNIN_TEST
    atomic_set(&fsm_module_switch, 0);
    atomic_set(&fsm_runin_test, 0);
#endif
    snd_soc_add_codec_controls(codec, fsm_afe_controls,
            ARRAY_SIZE(fsm_afe_controls));
}
#else
#define fsm_afe_mod_ctrl(...)
#define fsm_afe_init_controls(...)
#endif
