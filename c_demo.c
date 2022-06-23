
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int (*FOO)();

uint8_t instruction[] = {
    0x3b, 0x40, 0x06, 0x20, // mov %d2,100
    0x00, 0x90              // ret
};

uint8_t jitCode[100];

extern uint8_t __USTACK;
extern uint8_t __USTACK_TOP;

int main() {
  int a = 10;
  int b = 20;
  int c = a + b;
  int d = c * 2;
  (void)d;

  uint8_t *const stackBase = &__USTACK;
  uint8_t *const stackTop = &__USTACK_TOP;
  int stackSize = stackBase - stackTop;

  printf("stackBase %p, stackTop %p, stackSize %dk\n", stackBase, stackTop,
         stackSize / 1024);

  FOO foo = (FOO)&instruction;

  int const e1 = foo();

  memcpy(jitCode, instruction, sizeof(instruction));

  FOO foo2 = (FOO)&jitCode;

  int const e2 = foo2();

  printf("e1 == e2 %d\n", e1 == e2);

  const int dynamicAllocSize = 900 * 1024;

  char *const ptr = (char *)malloc(dynamicAllocSize);

  int sum = 0;

  if (ptr != NULL) {
    for (int i = 0; i < dynamicAllocSize; i++) {
      ptr[i] = 1;
    }

    for (int i = 0; i < dynamicAllocSize; i++) {
      sum += ptr[i];
    }
  }

  printf("sum is %d\n", sum);

  return 0;
}