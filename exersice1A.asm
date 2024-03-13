.model small
.stack 100h
.data
    array dw 16 DUP(0) ; Define an array of 16 words, initially filled with 0s

.code
main PROC
    mov ax, @data       ; Initialize data segment
    mov ds, ax

    ; Prepare our loop
    mov bx, 0           ; Initial position in the array
    mov cx, 0           ; Loop counter
    mov ax, 3           ; First element of the array

array_loop:
    ; Use ax and dx as temporary registers to hold the last two Fibonacci numbers
    mov [array + bx], ax  ; Store F(n) in the array
    add bx, 2             ; Move to the next position in the array (words)
    add ax, 3             ; next number in the sequence
    inc cx
    cmp cx, 16
    jne array_loop    ; Repeat if cx != 16

    mov ax, 4C00h       ; Terminate program
    int 21h
main ENDP
END main