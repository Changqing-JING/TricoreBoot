
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int (*FOO)();

uint8_t instruction[] = {
    0x3b, 0x40, 0x06, 0x20, //mov %d2,100
    0x00, 0x90 //ret
};

uint8_t jitCode[100];

extern uint8_t __USTACK;
extern uint8_t __USTACK_TOP;


int main(){
    int a = 10;
    int b = 20;
    int c = a+b;
    int d = c*2;
    (void)d;

    uint8_t* stackBase  = &__USTACK;
    uint8_t* stackTop = &__USTACK_TOP;
    int stackSize = stackBase - stackTop;

    printf("stackBase %p, stackTop %p, stackSize %dk\n", stackBase, stackTop, stackSize/1024);

    FOO foo = (FOO)&instruction;

    int e1 = foo();

    memcpy(jitCode, instruction, sizeof(instruction));

    FOO foo2 = (FOO)&jitCode;

    int e2 = foo2();

    printf("e1 == e2 %d\n", e1 == e2);

    return 0;
}