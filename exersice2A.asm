.model small
.stack 100h

.code
main PROC
    mov ax, 30
    mov bx, 20
    call smollest_from_ax_bx

    mov ax, 4C00h       ; Terminate program
    int 21h
main ENDP

smollest_from_ax_bx PROC
    cmp ax, bx
    jle final
    mov ax, bx
    final:
    ret
smollest_from_ax_bx endp

end main