.model small
.stack 100h

.data
    msg1 db "Enter a positive integer (0 to exit): $"
    msg2 db "Fibonacci: $"
    n db 0                   ; To store the input value of n
    fib1 db 0                ; fib(0)
    fib2 db 1                ; fib(1)
    result db 0              ; To store the result
    newline db 0Dh, 0Ah, '$' ; New line for output formatting

.code
main proc
    mov ax, @data            ; Initialize data segment
    mov ds, ax

input_loop:
    ; Print message to enter the value of n
    mov ah, 09h              ; DOS function to print string
    lea dx, msg1             ; Load address of message
    int 21h                  ; Call DOS interrupt

    ; Read the input value of n
    mov ah, 01h              ; DOS function to read character
    int 21h                  ; Call DOS interrupt
    sub al, '0'              ; Convert ASCII to decimal
    mov n, al                ; Store the input value in n

    
    ; Load the value of n
    mov al, n                ; Load n into AL
    cmp al, 1                ; Check if n is 1
    je .fibonacci_one        ; If n is 1, jump to fibonacci_one
    
    ; Load the value of n
    mov al, n                ; Load n into AL
    cmp al, 0                ; Check if n is 0
    je .fibonacci_zero        ; If n is 0, jump to fibonacci_zero

    ; Initialize Fibonacci variables
    mov bl, 0                ; fib(0)
    mov bh, 1                ; fib(1)
    mov cl, 2                ; Start from fib(2)

.fibonacci_loop:
    ; Calculate fib(n) = fib(n-1) + fib(n-2)
    mov al, bl               ; Move fib(n-2) to AL
    add al, bh               ; fib(n) = fib(n-1) + fib(n-2)
    mov result, al           ; Store the result
    mov bl, bh               ; Move fib(n-1) to fib(n-2)
    mov bh, result           ; Move fib(n) to fib(n-1)
    inc cl                   ; Increment the counter
    cmp cl, n                ; Compare counter with n
    jle .fibonacci_loop      ; If counter <= n, repeat

    jmp .print_result

.fibonacci_one:
    mov result, 1            ; fib(1) = 1
    jmp .print_result

.fibonacci_zero:
    mov result, 0           ; fib(0) = 0
    jmp .print_result

    
    
    
    

.print_result:
    ; Print the newline for formatting
    mov ah, 09h              ; DOS function to print string
    lea dx, newline          ; Load address of newline
    int 21h                  ; Call DOS interrupt

    ; Print the message
    mov ah, 09h              ; DOS function to print string
    lea dx, msg2             ; Load address of message
    int 21h                  ; Call DOS interrupt

    ; Print the Fibonacci result
    mov al, result           ; Load the result into AL
    add al, '0'              ; Convert to ASCII
    mov dl, al               ; Move ASCII character to DL
    mov ah, 02h              ; DOS function to print character
    int 21h                  ; Call DOS interrupt

    ; Print the newline for formatting
    mov ah, 09h              ; DOS function to print string
    lea dx, newline          ; Load address of newline
    int 21h                  ; Call DOS interrupt

    jmp input_loop           ; Repeat for the next input

.exit_program:
  
    mov ax, 4C00h            
    int 21h                  
main endp
end main