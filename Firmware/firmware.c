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

#define LED     (*((volatile uint32_t *)0x0))

void wait3Seconds(void)
{
    __asm("counter: .word 30000000");
    __asm("          LUI   a0, %hi(counter)"); // 2
    __asm("          LW    a0, %lo(counter)(a0)"); // 2
    

    __asm("loop:                    ");
    __asm("          ADDI  a0, a0, -1"); // 1
    __asm("          BEQZ  a0, done"); // 1
    __asm("          JAL   x0, loop"); // 2
    __asm("done:                    "); // 4 Total * Counter
}

void main() {
    
    int i;
    static const int arr[10] = {9, 28, 53, 88, 52, 9, 75, 6, 26, 7};
    int maxNumber = arr[0];

    wait3Seconds();

    for(i = 1;i < 10; i++)
    {
       if(maxNumber < arr[i])
           maxNumber = arr[i] ;
    }

    volatile char *tx1 = (volatile char *)0x40002000;
    const char *result = "The largest element is ";
    while(*result)
    {
        *tx1 = *result;
        result++;
    }


    *tx1 = maxNumber;

    return;
}