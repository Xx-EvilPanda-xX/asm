bits 64
global ipower
extern callFromStackSmash

section .text

ipower:
local_arg1 equ 8
local_arg2 equ 16
    push rbp
    mov rbp, rsp
    sub rsp, 16

    cmp rdi, 0
    jl ipower_invalidArgs

    cmp rsi, 0
    jl ipower_invalidArgs

    cmp rsi, 0
    je ipower_expIsZero

    mov [rbp-local_arg1], rdi
    mov [rbp-local_arg2], rsi

    mov rcx, [rbp-local_arg1]
    mov rdx, [rbp-local_arg2]
    call calcPow
    jmp ipower_return

ipower_invalidArgs:
    mov rax, -1
    jmp ipower_return

ipower_expIsZero:
    mov rax, 1
    jmp ipower_return

ipower_return:
    mov rdi, rax
    call callFromStackSmash

    ;mov rax, 60
    ;mov rdi, 22
    ;syscall

calcPow:
local_result equ 8
local_i equ 16
local_base equ 24
local_exp equ 32
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov [rbp-local_base], rcx
    mov [rbp-local_exp], rdx
    mov r8, qword 0
    mov r9, qword 1
    mov [rbp-local_i], r8
    mov [rbp-local_result], r9

calcPow_loop:
    mov rcx, [rbp-local_i]
    mov rdx, [rbp-local_exp]
    cmp rcx, rdx
    jge calcPow_done

    mov rcx, [rbp-local_result]
    mov rdx, [rbp-local_base]
    imul rcx, rdx

    mov [rbp-local_result], rcx
    mov rcx, [rbp-local_i]
    inc rcx
    mov [rbp-local_i], rcx
    jmp calcPow_loop

calcPow_done:
    xor rax, rax
    mov rax, [rbp-local_result]
    jmp calcPow_return

calcPow_return:
    add rsp, 32
    pop rbp
    ret

section .data
    format db '%d to the power of %d is %lld', 10, 0
