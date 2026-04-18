###
# Copyright (C) Fourier Semiconductor Inc. 2016-2020. All rights reserved.
#

# TOPLEVEL=$(PWD)/..
# EXTRA_CFLAGS += -I$(TOPLEVEL)

# EXTRA_CFLAGS += -DDEBUG -DFSM_DEBUG
EXTRA_CFLAGS += -Wall -Werror
MODFLAGS = -fno-pic
CFLAGS_MODULE = $(MODFLAGS)
AFLAGS_MODULE = $(MODFLAGS)

snd-soc-fs19xx-objs := fsm_core.o
snd-soc-fs19xx-objs += fs19xx.o
snd-soc-fs19xx-objs += fsm_i2c.o

obj-$(CONFIG_SND_SOC_FS18XX) += snd-soc-fs19xx.o

EXTRA_CFLAGS += -Itechpack/audio/include
EXTRA_CFLAGS += -Itechpack/audio/include/uapi