;─────────────────────────────────────────────────────────
;  days.asm   —  NASM x86-64 (Windows) demo
;               assemble :  nasm -f win64 days.asm -o days.obj
;               link (GCC) : gcc days.obj -o days.exe -lmsvcrt
;─────────────────────────────────────────────────────────
        default rel                    ; enable RIP-relative addressing

;─── 1. Symbolic integer constants ─────────────────────
%define MONDAY      0
%define TUESDAY     1
%define WEDNESDAY   2
%define THURSDAY    3
%define FRIDAY      4
%define SATURDAY    5
%define SUNDAY      6

;─── 2. Data ────────────────────────────────────────────
section .data
Days    dd  MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
ArraySz equ ($ - Days) / 4       ; assemble-time size = 7

fmtStr  db  "Day: %u", 13, 10, 0

;─── 3. Code ────────────────────────────────────────────
section .text
extern  printf
global  main

main:
    xor     esi, esi              ; i = 0

.loop:
    cmp     esi, ArraySz
    jge     .done

    ; ————————————————————————————————————————————
    ; load & print: printf( fmtStr, i, Days[i] )
    ; Win64 ABI: RCX, RDX, R8, R9 are the first four integer args
    ; RCX = fmtStr, RDX = i, R8D = Days[i]
    ;————————————————————————————————————————————
    lea     rcx,  [rel fmtStr]    ; RCX ← address of format string
    mov     edx,  esi             ; RDX ← index (i)

    ; workaround NASM rip+scale limitation:
    lea     rax,  [rel Days]      ; RAX ← base address of Days[]
    mov     eax,  [rax + rsi*4]   ; EAX ← Days[i]
    mov     r8d,  eax             ; R8D ← Days[i]

    sub     rsp, 32               ; MS x64 shadow-space (32 bytes)
    call    printf
    add     rsp, 32

    inc     esi
    jmp     .loop

.done:
    xor     eax, eax              ; return 0
    ret
