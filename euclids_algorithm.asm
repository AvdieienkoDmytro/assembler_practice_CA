.model small
.stack 100h

.code
main PROC
    mov ax, 30
    mov bx, 20
    call euclids_algorithm_ax_bx

    mov ax, 4C00h       ; Terminate program
    int 21h
main ENDP

euclids_algorithm_ax_bx PROC ; AX = a, BX = b -> AX = gcd(a, b)
    algorithm_loop: ; while a != b
        cmp ax, bx
        je final
        jg a_greater_than_b
        jl b_greater_than_a

        a_greater_than_b: ; a > b
        sub ax, bx
        jmp algorithm_loop

        b_greater_than_a: ; b > a
        sub bx, ax
        jmp algorithm_loop

        final: ; AX = gcd(a, b)
        ret
euclids_algorithm_ax_bx endp

end main