global    _start
          section   .text
_start:
          mov       rbp, rsp
          sub       rsp, 184
          lea       rdx, [rbp-184]
          mov       r8, 1
          mov       r9, 0
          mov       [rdx], byte 124
          inc       rdx
line:
          mov       [rdx], byte 64
          inc       rdx
          inc       r9
          cmp       r9, r8
          jne       line
lineDone:
          mov       [rdx], byte 92
          inc       rdx
          mov       [rdx], byte 10
          inc       rdx
          mov       [rdx], byte 124
          inc       rdx
          inc       r8
          mov       r9, 0
          cmp       r8, 15
          jng       line
          mov       [rdx], byte 10
          dec       rdx
          xor       rbx, rbx
          jmp       lastLine
done:
          mov       rax, 1
          mov       rdi, 1
          lea       rsi, [rbp-184]
          mov       rdx, 184
          syscall
          mov       rax, 60
          xor       rdi, rdi
          syscall
lastLine:
          mov       [rdx], byte 96
          inc       rdx
          inc       rbx
          cmp       rbx, 17
          jng       lastLine
          mov       [rdx], byte 10
          jmp       done