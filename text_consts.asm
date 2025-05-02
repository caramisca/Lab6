;─────────────────────────────────────────────────────────
;  text_consts.asm  — NASM x86-64 (Windows) demo
;    assemble : nasm -f win64 text_consts.asm -o text_consts.obj
;    link (GCC): gcc text_consts.obj -o text_consts.exe -lmsvcrt
;    run      : .\text_consts.exe
;─────────────────────────────────────────────────────────
        default rel
        global  main
        extern  printf

;─── 1. Symbolic text constants ─────────────────────────
%define GREETING    "Hello from NASM!"
%define FAREWELL    "Goodbye from NASM!"
%define QUESTION    "How are you today?"

;─── 2. Data ────────────────────────────────────────────
section .data
fmtStr   db  "%s", 13, 10, 0           ; printf format: string + newline
greetMsg db  GREETING, 0               ; uses the GREETING literal
questMsg db  QUESTION, 0               ; uses the QUESTION   literal
byeMsg   db  FAREWELL, 0               ; uses the FAREWELL   literal

;─── 3. Code ────────────────────────────────────────────
section .text
main:
    xor     ecx, ecx   ; just to clear, not strictly needed

    ; -> printf(fmtStr, greetMsg)
    lea     rcx, [rel fmtStr]
    lea     rdx, [rel greetMsg]
    xor     eax, eax   ; required zero for varargs
    sub     rsp, 32    ; shadow space
    call    printf
    add     rsp, 32

    ; -> printf(fmtStr, questMsg)
    lea     rcx, [rel fmtStr]
    lea     rdx, [rel questMsg]
    xor     eax, eax
    sub     rsp, 32
    call    printf
    add     rsp, 32

    ; -> printf(fmtStr, byeMsg)
    lea     rcx, [rel fmtStr]
    lea     rdx, [rel byeMsg]
    xor     eax, eax
    sub     rsp, 32
    call    printf
    add     rsp, 32

    xor     eax, eax   ; return 0
    ret
