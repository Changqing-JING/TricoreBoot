
.text
.global _start
_start:
    movh  %d6, 0
    movh  %d7, 0x3ff0
    movh  %d10, 0
    movh  %d11, 0xfff8
    cmp.df  %d8, %e6, %e10
    movh %d2, 16384
    movh %d3, 16256
    add.f %d2, %d2, %d3
    ret
    
