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

    ; Prepare for zeros loop
    mov bx, 0           ; Initial position in the array
    mov cx, 0           ; Loop counter
    mov ax, 0           ; First element of the array

zero_loop:
    ; Use ax and dx as temporary registers to hold the last two Fibonacci numbers
    mov [array + bx], ax  ; Store F(n) in the array
    add bx, 2             ; Move to the next position in the array (words)
    mov ax, 0             ; next number in the sequence
    inc cx
    cmp cx, 16
    jne zero_loop    ; Repeat if cx != 16

    ; Prepare fibonacci loop
    mov bx, 0           ; Initial position in the array
    mov cx, 0           ; Loop counter
    mov ax, 0           ; First Fibonacci number
    mov dx, 1           ; Second Fibonacci number

    mov [array + bx], ax ; Store the first Fibonacci number in the array
    mov [array + bx + 2], dx ; Store the second Fibonacci number in the array
    add bx, 4             ; Move to the next position in the array (words)

fibonacci_loop:
    ; Use ax and dx as temporary registers to hold the last two Fibonacci numbers
    add dx, ax            ; Calculate the last Fibonacci number
    mov [array + bx], dx  ; Store the last Fibonacci number in the array
    mov ax, [array + bx - 2]  ; Save the previous Fibonacci number to ax
    add bx, 2             ; Move to the next position in the array (words)
    inc cx
    cmp cx, 14
    jne fibonacci_loop    ; Repeat if cx != 14

    mov ax, 4C00h       ; Terminate program
    int 21h
main ENDP
END main