#ifndef __HALL_REPORT_H
#define __HALL_REPORT_H

int hall_report_register(struct device *dev);
void hall_report_unregister(void);

int hall_report_value(int value);

#endif
