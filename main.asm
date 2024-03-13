; test 1
.model small

.data

.code
main PROC
    MOV AX, 1
    MOV BX, 0
    MOV CX, 5

    @sum:
    add bx, ax
    inc bx

    loop @sum

main ENDP
end main
