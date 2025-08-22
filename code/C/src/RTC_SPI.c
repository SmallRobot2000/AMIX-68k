
#include <stdint.h>

// These macros must be adapted to set/clear or read status/control bits from your 16550 UART device
#define UART_BASE  0xFF0000  /* Replace with your UART's base address */
// For OUT2, OUT1, DTR write: control register (MCR)
// OUT2 Bit: 0x08, OUT1 Bit: 0x04, DTR Bit: 0x01
#define UART_MCR   (*(volatile uint8_t *)(UART_BASE + 8))
// For DCD read: status register (MSR)
// DCD is bit 0x80 in MSR
#define UART_MSR   (*(volatile uint8_t *)(UART_BASE + 12))
#define DS3234_CTRL_REG     0x0E
#define DS3234_STAT_REG     0x0F

// Set Chip Select LOW (active)
static inline void SPI_CS_LOW(void) {
    UART_MCR |= 0x08; // OUT2 = 0
}

// Set Chip Select HIGH (inactive)
static inline void SPI_CS_HIGH(void) {
    UART_MCR &= ~0x08; // OUT2 = 1
}

// Set CLK HIGH
static inline void SPI_CLK_HIGH(void) {
    UART_MCR |= 0x04; // OUT1 = 1
}

// Set CLK LOW
static inline void SPI_CLK_LOW(void) {
    UART_MCR &= ~0x04; // OUT1 = 0
}

// Set MOSI (COPI) HIGH or LOW
static inline void SPI_COPI_HIGH(void) {
    UART_MCR &= ~0x01; // DTR = 1
}
static inline void SPI_COPI_LOW(void) {
    UART_MCR |= 0x01; // DTR = 0
}

// Read MISO (CIPO) value
static inline int SPI_CIPO_READ(void) {
    return (UART_MSR & 0x80) ? 1 : 0; // DCD (bit 7, 0x80)
}

// Send a byte via SPI (mode 1, CPOL=0 CPHA=1)
void SPI_SEND(uint8_t data) {
    for (int i = 7; i >= 0; i--) {
        // Set MOSI (controller out)
        if (data & (1 << i))
            SPI_COPI_HIGH();
        else
            SPI_COPI_LOW();

        // Clock high then low
        SPI_CLK_HIGH();
        // (Optional: short delay here)
        SPI_CLK_LOW();
    }
}

// Receive a byte via SPI (mode 1, CPOL=0 CPHA=1)
uint8_t SPI_RECEVE(void) {
    uint8_t value = 0;
    for (int i = 7; i >= 0; i--) {
        SPI_CLK_HIGH();
        // (Optional: short delay here)
        if (SPI_CIPO_READ())
            value |= (1 << i);
        SPI_CLK_LOW();
        // (Optional: short delay here)
    }
    return ~value;
}
// DS3234 register addresses
#define DS3234_REG_SEC    0x00
#define DS3234_REG_MIN    0x01
#define DS3234_REG_HOUR   0x02
#define DS3234_REG_DAY    0x03
#define DS3234_REG_DATE   0x04
#define DS3234_REG_MON    0x05
#define DS3234_REG_YEAR   0x06
#define DS3234_CTRL_REG   0x0E
#define DS3234_STAT_REG   0x0F

// BCD conversion helpers
static inline uint8_t to_bcd(uint8_t v)   { return ((v / 10) << 4) | (v % 10); }
static inline uint8_t from_bcd(uint8_t v) { return ((v >> 4) * 10) + (v & 0x0F); }

// Low-level register R/W (correct MSB conventions)
static void ds3234_write_register(uint8_t addr, uint8_t val) {
    SPI_CS_LOW();
    SPI_SEND(addr | 0x80);  // MSB=1 for write
    SPI_SEND(val);
    SPI_CS_HIGH();
}

static uint8_t ds3234_read_register(uint8_t addr) {
    SPI_CS_LOW();
    SPI_SEND(addr & 0x7F);  // MSB=0 for read
    uint8_t v = SPI_RECEVE();
    SPI_CS_HIGH();
    return v;
}

// Initialize the RTC (disable SQW, clear flags, enable oscillator)
void rtc_init(void) {
    SPI_CS_HIGH();
    // Control: EOSC=0 (osc on), INTCN=1 (disable SQW), other bits=0
    ds3234_write_register(DS3234_CTRL_REG, 0x04);
    // Clear status flags, especially OSF bit
    ds3234_write_register(DS3234_STAT_REG, 0x00);
}

// Set time: sec, min, hour, day_of_week (1–7), date, month, year (00–99)
void rtc_set_time(uint8_t sec, uint8_t min, uint8_t hour,
                  uint8_t day, uint8_t date, uint8_t mon, uint8_t year) {
    SPI_CS_LOW();
    SPI_SEND(DS3234_REG_SEC | 0x80);
    SPI_SEND(to_bcd(sec));
    SPI_SEND(to_bcd(min));
    SPI_SEND(to_bcd(hour));
    SPI_SEND(to_bcd(day));
    SPI_SEND(to_bcd(date));
    SPI_SEND(to_bcd(mon));
    SPI_SEND(to_bcd(year));
    SPI_CS_HIGH();
}

// Get time back into binary variables
void rtc_get_time(uint8_t *sec, uint8_t *min, uint8_t *hour,
                  uint8_t *day, uint8_t *date, uint8_t *mon, uint8_t *year) {
    SPI_CS_LOW();
    SPI_SEND(DS3234_REG_SEC & 0x7F);
    *sec  = from_bcd(SPI_RECEVE());
    *min  = from_bcd(SPI_RECEVE());
    *hour = from_bcd(SPI_RECEVE());
    *day  = from_bcd(SPI_RECEVE());
    *date = from_bcd(SPI_RECEVE());
    *mon  = from_bcd(SPI_RECEVE());
    *year = from_bcd(SPI_RECEVE());
    SPI_CS_HIGH();
}