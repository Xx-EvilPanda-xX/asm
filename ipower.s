global main
extern printf
extern atol

section .text

main:
local_arg1 equ 8
local_arg2 equ 16
    push rbp
    mov rbp, rsp
    sub rsp, 24

    cmp rdi, 3
    jne .invalidNumArgs

    mov rdi, [rsi+8]
    push rsi
    call atol
    pop rsi
    mov [rbp-local_arg1], rax

    mov rdi, [rsi+16]
    push rsi
    call atol
    pop rsi
    mov [rbp-local_arg2], rax

    mov rcx, [rbp-local_arg1]
    mov rdx, [rbp-local_arg2]
    call calcPow

    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx

    mov rdi, format
    mov rsi, [rbp-local_arg1]
    mov rdx, [rbp-local_arg2]
    mov rcx, rax
    xor rax, rax
    call printf
    jmp .return
    
.invalidNumArgs:
    mov rdi, error1
    xor rax, rax
    call printf
    jmp .return

.return:
    add rsp, 24
    pop rbp
    ret

calcPow:
local_result equ 8
local_i equ 16
local_base equ 24
local_exp equ 32
    push rbp
    mov rbp, rsp
    sub rsp, 40

    cmp rcx, 0
    je .baseIsZero

    mov [rbp-local_base], rcx
    mov [rbp-local_exp], rdx
    mov r8, qword 0
    mov r9, qword 1
    mov [rbp-local_i], r8
    mov [rbp-local_result], r9

.loop:
    mov rcx, [rbp-local_i]
    mov rdx, [rbp-local_exp]
    cmp rcx, rdx
    jge .done

    mov rcx, [rbp-local_result]
    mov rdx, [rbp-local_base]
    imul rcx, rdx

    mov [rbp-local_result], rcx
    mov rcx, [rbp-local_i]
    inc rcx
    mov [rbp-local_i], rcx
    jmp .loop

.done:
    xor rax, rax
    mov rax, [rbp-local_result]
    jmp .return

.baseIsZero:
    mov rax, 0
    mov rcx, [rbp-local_exp]
    cmp rcx, 0
    je .expIsZero
    jmp .return

.expIsZero:
    mov rax, 1
    jmp .return
    

.return:
    add rsp, 40
    pop rbp
    ret

section .data
    format db '%d to the power of %d is %lld', 10, 0
    error1 db 'incorrect number of arguments! Usage: ipower [base] [exponent]', 10, 0
