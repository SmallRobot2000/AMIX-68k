#include <stdio.h>
#include <string.h>
#include <stdint.h>

int main(void) {
    double c = 0.071264;
    int i    = 63000;

    char *str1 = "ooa str!";
    char str[20];
    memcpy(str,str1,strlen(str1) + 1);
    printf("Haljo %f\n", c);
    printf("123dasdas %d\n", i);
    printf("Hej there\n");
    printf("test \niiii \nm\n%s",str);
     
    return 0;
}
