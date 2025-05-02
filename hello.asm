global main
extern printf
extern Sleep

section .data
    msg db "Hello, World!", 0xA, 0

section .text
main:
    ; printf("Hello, World!\n")
    lea rcx, [rel msg]   ; first argument to printf (RIP-relative)
    call printf

    ; Sleep(5000)
    mov rcx, 5000       ; first argument: 5000 ms = 5 seconds
    call Sleep

    xor eax, eax
    ret
