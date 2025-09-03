#define DEBUG
//#define DEBUG_ELF

#ifdef DEBUG
  #define DBG_PRINTF(fmt, ...) \
    do { fprintf(stderr, fmt, ##__VA_ARGS__); } while (0)
#else
  #define DBG_PRINTF(fmt, ...) do { } while (0)
#endif

#ifdef DEBUG_ELF
  #define DBG_ELF_PRINTF(fmt, ...) \
    do { fprintf(stderr, fmt, ##__VA_ARGS__); } while (0)
#else
  #define DBG_ELF_PRINTF(fmt, ...) do { } while (0)
#endif
