// void putc(char c)
// {
// 	*(volatile char*)0x10000000 = c;
// }

// void puts(const char *s)
// {
// 	while (*s) putc(*s++);
// }

// void *memcpy(void *dest, const void *src, int n)
// {
// 	while (n) {
// 		n--;
// 		((char*)dest)[n] = ((char*)src)[n];
// 	}
// 	return dest;
// }

// int main()
// {
// 	int value = 15;
// 	int *memory_location = (int *)0x400;

// 	*memory_location = value;

// 	return 0;
// }

#include <stdint.h>
#include <stdbool.h>

#define LED     (*((volatile uint32_t *)0x10))

void wait3Seconds(void)
{
    __asm("          LUI  a0, 0x2000"); // 2
    __asm("loop:                     "); // 2
    __asm("          ADDI  a0, a0, -1"); // 1
    __asm("          BNEZ  a0, loop"); // 1
    return;
}

void toggleLED(void)
{
    LED = 1;
    return;
}

void main() {
    wait3Seconds();
    toggleLED();

    while(true);
}