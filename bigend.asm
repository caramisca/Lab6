;─────────────────────────────────────────────────────────
;  bigend.asm — store a 32-bit (doubleword) constant in BE
;    assemble : nasm -f win64 bigend.asm -o bigend.obj
;    link (GCC): gcc bigend.obj -o bigend.exe
;    run      : .\bigend.exe
;─────────────────────────────────────────────────────────
        default rel
        global  main

section .data
; we want the 32-bit value 0x12345678 in big-endian order:
;    memory[0] = 0x12
;    memory[1] = 0x34
;    memory[2] = 0x56
;    memory[3] = 0x78
myVal_BE  db  0x12, 0x34, 0x56, 0x78

; (If you prefer 'dd', you can reverse the constant:)
;myVal_BE  dd  0x78563412   ; little-endian store of reversed gives BE layout

section .text
main:
    ; nothing to do — just return
    xor     eax, eax
    ret
