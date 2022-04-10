        global  main
        extern printf

        section .text
main:
        push    rbx

        mov     rcx, 20
        xor     rax, rax
        xor     rbx, rbx
        inc     rbx
print:
        push    rax
        push    rcx

        mov     rdi, format
        mov     rsi, rax
        xor     rax, rax

        call    printf

        pop     rcx
        pop     rax

        mov     rdx, rax
        mov     rax, rbx
        add     rbx, rdx
        dec     rcx
        jnz     print

        pop     rbx                     
        ret
format:
        db  '%d', 10, 0
