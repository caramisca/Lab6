; minint.asm — declare a 32-bit signed integer at its minimum value

BITS 64
global main

section .data
    ; signed 32-bit minimum: –2³¹ = –2147483648
    minval  dd  -2147483648

section .text
main:
    xor     eax, eax    ; return 0
    ret
