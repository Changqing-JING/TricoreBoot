.section ".text"

.globl _start

_start:
    mov.u %d1, 10
    mov %d2, 20
    add %d3, %d1, %d2
loop:
    mov %d4, 30
    J loop

.section ".shared_data"

filename: .byte 1