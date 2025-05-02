; little.asm — store 0x456789AB and inspect bytes

BITS 64
global main

section .data
    ; Define the dword constant 0x456789AB
    val     dd  0x456789AB

section .text
main:
    xor     eax, eax    ; return 0
    ret
