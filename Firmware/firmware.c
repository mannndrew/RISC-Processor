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

#define TEST     (*((volatile uint32_t *)0x40))
int my_data_variable = 42;

uint32_t add(uint32_t num)
{
    uint32_t value = num;
    value += 67;
    value = value << 4;
    return value;
}

int main() {
    uint32_t a = TEST;
    return add(a);
}