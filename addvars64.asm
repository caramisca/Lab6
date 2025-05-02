;──────────────────────────────────────────────────────────
;  addvars64.asm — NASM x86-64 (Windows) demo
;    assemble : nasm -f win64 addvars64.asm -o addvars64.obj
;    link (GCC): gcc addvars64.obj -o addvars64.exe -lmsvcrt
;    run      : .\addvars64.exe
;──────────────────────────────────────────────────────────
        default rel
        global  main
        extern  printf

;─── 1. Data (64-bit variables) ─────────────────────────
section .data
firstval   dq  0x20002000_00000000      ; example 64-bit hex
secondval  dq  0x11111111_11111111
thirdval   dq  0x22222222_22222222
sum        dq  0

fmtStr     db  "Sum = %llu", 13, 10, 0  ; unsigned 64-bit format

;─── 2. Code ────────────────────────────────────────────
section .text
main:
    ; load each 64-bit variable into RAX and accumulate
    mov     rax, [rel firstval]    ; RAX ← firstval
    add     rax, [rel secondval]   ; RAX ← RAX + secondval
    add     rax, [rel thirdval]    ; RAX ← RAX + thirdval
    mov     [rel sum], rax         ; store back into sum

    ; print with printf(fmtStr, sum)
    lea     rcx, [rel fmtStr]      ; RCX ← address of format
    mov     rdx, rax               ; RDX ← sum value
    xor     eax, eax               ; RAX=0 (varargs ABI)
    sub     rsp, 32                ; shadow space
    call    printf
    add     rsp, 32

    xor     eax, eax               ; return 0
    ret
