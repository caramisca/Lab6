; darray.asm — NASM x86-64 (Windows) demo
BITS 64
global main

section .bss
    ; reserve space for 50 signed doublewords (4 bytes each)
    dArray  resd 50

section .text
main:
    xor     eax, eax    ; return 0
    ret
