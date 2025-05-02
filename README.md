# Lab 6 Assembly Problems Report

This report summarizes the eight short assembly-language problems solved for a Windows x64 (NASM + GCC) environment.

---

### Problem 1: Symbolic Integer Constants

**Task:** Define symbolic constants for days of the week and store them in a 4‑byte array; print each day value.

```nasm
; days.asm — NASM x86-64 (Windows)
BITS 64
global main
extern printf

section .data
    fmt    db "Day: %d",10,0
    days   dd MON, TUE, WED, THU, FRI, SAT, SUN
    MON    equ 0
    TUE    equ 1
    WED    equ 2
    THU    equ 3
    FRI    equ 4
    SAT    equ 5
    SUN    equ 6
    num_days equ 7

section .text
main:
    xor   rbx, rbx
.loop:
    cmp   rbx, num_days
    jge   .done
    mov   eax, [rel days + rbx*4]
    lea   rcx, [rel fmt]
    mov   edx, eax
    xor   eax, eax
    call  printf
    inc   rbx
    jmp   .loop
.done:
    xor   eax, eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 days.asm -o days.obj
gcc days.obj -o days.exe -lmsvcrt
./days.exe
```

**Output:**

```
Day: 0
Day: 1
Day: 2
Day: 3
Day: 4
Day: 5
Day: 6
```

---

### Problem 2: Symbolic Text Constants

**Task:** Define symbolic names for string literals and use them in data definitions; print each.

```nasm
; text_consts.asm — NASM x86-64 (Windows)
BITS 64
global main
extern printf

section .data
    fmtStr   db "%s",10,0
    GREETING    db "Hello from NASM!",0
    QUESTION    db "How are you today?",0
    FAREWELL    db "Goodbye from NASM!",0

section .text
main:
    ; printf(fmtStr, GREETING)
    lea   rcx, [rel fmtStr]
    lea   rdx, [rel GREETING]
    xor   eax, eax
    sub   rsp, 32
    call  printf
    add   rsp, 32

    ; printf(fmtStr, QUESTION)
    lea   rcx, [rel fmtStr]
    lea   rdx, [rel QUESTION]
    xor   eax, eax
    sub   rsp, 32
    call  printf
    add   rsp, 32

    ; printf(fmtStr, FAREWELL)
    lea   rcx, [rel fmtStr]
    lea   rdx, [rel FAREWELL]
    xor   eax, eax
    sub   rsp, 32
    call  printf
    add   rsp, 32

    xor   eax, eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 text_consts.asm -o text_consts.obj
gcc text_consts.obj -o text_consts.exe -lmsvcrt
./text_consts.exe
```

**Output:**

```
Hello from NASM!
How are you today?
Goodbye from NASM!
```

---

### Problem 3: Integer Expression Calculation

**Task:** Compute `A = (A + B) − (C + D)` with registers, then print the result.

```nasm
; expr.asm — NASM x86-64 (Windows)
BITS 64
global main
extern printf

section .data
    fmtStr  db "Result: %d",10,0

section .text
main:
    mov   eax, 10    ; A
    mov   ebx, 7     ; B
    mov   ecx, 3     ; C
    mov   edx, 4     ; D
    add   eax, ebx   ; A+B
    add   ecx, edx   ; C+D
    sub   eax, ecx   ; (A+B)-(C+D)
    lea   rcx, [rel fmtStr]
    mov   edx, eax
    xor   eax, eax
    sub   rsp, 32
    call  printf
    add   rsp, 32
    xor   eax, eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 expr.asm -o expr.obj
gcc expr.obj -o expr.exe -lmsvcrt
./expr.exe
```

**Output:**

```
Result: 10
```

---

### Problem 4: 64‑bit AddVariables Program

**Task:** Modify the AddVariables example to use 64-bit variables and registers; print the sum.

```nasm
; addvars64.asm — NASM x86-64 (Windows)
BITS 64
global main
extern printf

section .data
    fmtStr    db "Sum = %llu",10,0
    firstval  dq 0x2000200000000000
    secondval dq 0x1111111111111111
    thirdval  dq 0x2222222222222222
    sum       dq 0

section .text
main:
    mov   rax, [rel firstval]
    add   rax, [rel secondval]
    add   rax, [rel thirdval]
    mov   [rel sum], rax
    lea   rcx, [rel fmtStr]
    mov   rdx, rax
    xor   eax, eax
    sub   rsp, 32
    call  printf
    add   rsp, 32
    xor   eax, eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 addvars64.asm -o addvars64.obj
gcc addvars64.obj -o addvars64.exe -lmsvcrt
./addvars64.exe
```

**Output:**

```
Sum = 5995227008327693107
```

---

### Problem 5: Big‑Endian Doubleword Definition

**Task:** Store a 32-bit constant in memory in big‑endian order.

```nasm
; bigend.asm — NASM x86-64 (Windows)
BITS 64
global main

section .data
    ; 0x12345678 in big‑endian bytes
    myVal_BE db 0x12,0x34,0x56,0x78

section .text
main:
    xor   eax, eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 bigend.asm -o bigend.obj
gcc bigend.obj -o bigend.exe
./bigend.exe
```

**Verify:**

```bash
objdump -t bigend.exe | grep myVal_BE  # find VA
objdump -s -j .data --start-address=0x<VA> --stop-address=0x<VA+4> bigend.exe
```

You will see `12 34 56 78` in memory.

---

### Problem 6: Little‑Endian Byte Listing

**Task:** Given `456789ABh`, list its 4 bytes in little‑endian order.

```nasm
; little.asm — NASM x86-64 (Windows)
BITS 64
global main

section .data
    val dd 0x456789AB

section .text
main:
    xor eax,eax
    ret
```

**Build & Run & Inspect:**

```bash
nasm -f win64 little.asm -o little.obj
gcc little.obj -o little.exe
# find VA of 'val'
objdump -t little.exe | grep " val"
# dump bytes
objdump -s -j .data --start-address=0x<VA> --stop-address=0x<VA+4> little.exe
```

**Bytes:** `AB 89 67 45`

---

### Problem 7: Minimum 32‑bit Signed Integer

**Task:** Declare a 32-bit signed integer initialized to −2³¹ (−2147483648).

```nasm
; minint.asm — NASM x86-64 (Windows)
BITS 64
global main

section .data
    minval dd -2147483648

section .text
main:
    xor eax,eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 minint.asm -o minint.obj
gcc minint.obj -o minint.exe
./minint.exe
```

**Verify:**

```bash
# find VA
objdump -t minint.exe | grep minval
# dump
objdump -s -j .data --start-address=0x<VA> --stop-address=0x<VA+4> minint.exe
```

Bytes in memory: `00 00 00 80` (two's‑complement of −2³¹)

---

### Problem 8: Uninitialized Signed Doubleword Array

**Task:** Declare an uninitialized array of 50 signed doublewords (`dArray`).

```nasm
; darray.asm — NASM x86-64 (Windows)
BITS 64
global main

section .bss
    dArray resd 50  ; reserve 50 × 4 = 200 bytes

section .text
main:
    xor eax,eax
    ret
```

**Build & Run:**

```bash
nasm -f win64 darray.asm -o darray.obj
gcc darray.obj -o darray.exe
./darray.exe
```

**Verify Section Size:**

```bash
objdump -h darray.obj
```

Check `.bss` size = `0xC8` (200) bytes.
