.model small
.stack 100h

.code
main PROC
    push 20 ; 2nd argument
    push 30 ; 1st argument
    call smollest_from_ax_bx

    mov ax, 4C00h       ; Terminate program
    int 21h
main ENDP

smollest_from_ax_bx PROC
    pop dx ; save return address
    pop bx ; pop 1st argument
    pop ax ; pop 2nd argument
    push dx ; restore return address
    cmp ax, bx
    jle final
    mov ax, bx
    final:
    ret
smollest_from_ax_bx endp

end main