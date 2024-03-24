.model small
.stack 100h
.data
    array dw 12*12 DUP(0) ; Define array, initially filled with 0s

.code
main PROC
    mov ax, @data       ; Initialize data segment
    mov ds, ax

    mov ch, 0          ; Set loop counter for rows (X)
    mov cl, 0          ; Set loop counter for columns (Y)

myloop:
    call sub_y_minus_y_mul_x ; Y - Y*X
    
    ; AX = value, CH = row, CL = column
    mov bl, ch
    xor bh, bh
    mov dl, cl
    xor dh, dh
    ; AX = value, BX = row, DX = column
    call store_in_array
    
    inc cl
    cmp cl, 12
    jne myloop
    mov cl, 0
    inc ch
    cmp ch, 12
    jne myloop
    

    mov ax, 4C00h       ; Terminate program
    int 21h
main ENDP

sub_y_minus_y_mul_x PROC
    ; Y - Y*X
    xor ah, ah
    mov al, ch  ; X
    mov bl, cl  ; Y
    xor bh, bh  ; BH = 0 // so that we can use BX as a 16-bit register
    mul bx      ; AX = AX * BX  // AX = X * Y
    sub bx, ax  ; BX = BX - AX  // BX = Y  - (X * Y)
    mov ax, bx  ; AX = Y - (X * Y)
    ret
sub_y_minus_y_mul_x ENDP

store_in_array PROC ; AX = value, BX = row, DX = column
    ; save AX
    push ax
    ; find the address of the element in the word array
    ; first, find the address of the row
    mov ax, 12
    push dx
    mul bx
    pop dx
    ; now add the column stored in DX
    add ax, dx
    
    ; now multiply by 2 to get the offset in the array
    shl ax, 1
    mov bx, ax
    ; restore AX
    pop ax

    ; now store the result from BX into the array
    mov [array + bx], ax
    ret
store_in_array ENDP


END main
