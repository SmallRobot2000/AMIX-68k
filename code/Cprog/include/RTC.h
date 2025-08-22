#include <stdint.h>

void rtc_set_time(uint8_t sec, uint8_t min, uint8_t hr, uint8_t day, uint8_t date, uint8_t mon, uint8_t yr);
void rtc_get_time(uint8_t *sec, uint8_t *min, uint8_t *hr, uint8_t *day, uint8_t *date, uint8_t *mon, uint8_t *yr);
void rtc_init(void);