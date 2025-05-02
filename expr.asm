;─────────────────────────────────────────────────────────
;  expr.asm   — NASM x86-64 (Windows) demo
;    assemble : nasm -f win64 expr.asm -o expr.obj
;    link (GCC): gcc expr.obj -o expr.exe -lmsvcrt
;    run      : .\expr.exe
;─────────────────────────────────────────────────────────
        default rel
        global  main
        extern  printf

section .data
fmtStr  db  "Result: %d", 13, 10, 0

section .text
main:
    ; — load A, B, C, D into registers —
    mov     eax, 10      ; A = 10
    mov     ebx,  7      ; B =  7
    mov     ecx,  3      ; C =  3
    mov     edx,  4      ; D =  4

    ; — compute (A + B) in EAX —
    add     eax, ebx     ; EAX ← A + B

    ; — compute (C + D) in ECX —
    add     ecx, edx     ; ECX ← C + D

    ; — subtract: EAX ← (A + B) − (C + D) —
    sub     eax, ecx     ; EAX ← result

    ; — print with printf(fmtStr, result) —
    lea     rcx, [rel fmtStr]  ; RCX ← address of format string
    mov     edx, eax          ; RDX ← result (EAX)
    xor     eax, eax          ; RAX=0 for varargs
    sub     rsp, 32           ; allocate shadow space
    call    printf
    add     rsp, 32

    xor     eax, eax          ; return 0
    ret
