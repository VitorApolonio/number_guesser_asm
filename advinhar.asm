bits 64
default rel

section .data
    in_fmt db "%s", 0 ;formato da entrada (%s = string)
    ; textos p/ printf
    guess db "[TENTATIVA %d] Seu numero e %d (S ou N)? ", 0
    f_guess db "[TENTATIVA FINAL] Entao seu numero deve ser %d.", 0
    l_or_g db "Maior ou menor (> ou <)? ", 0
    
    min dq 1 ; valor minimo para chute
    max dq 100 ; valor maximo para chute
    num dq 50 ; valor do chute, media entre min e max
    ans db "N", 0 ; resposta do usuario

    attempt_num dq 1 ; contagem de tentativas

section .text
    global main ; ponto de entrada do programa
    extern ExitProcess
    extern printf
    extern scanf

main:
    ; boilerplate obrigatorio, acho q reserva espaco na pilha pro programa, sei la
    push rbp
    mov rbp, rsp
    sub rsp, 32

main_loop:
    ; verifica se ja foram gastas as 7 tentativas, se sim fala o numero com certeza
    mov rax, [attempt_num]
    cmp rax, 7
    je last_attempt

    ; tenta adivinhar o numero, e pergunta se esta certo
    mov rcx, guess
    mov rdx, [attempt_num]
    mov r8, [num]
    call printf
    mov rcx, in_fmt
    lea rdx, [ans]
    xor r8, r8
    call scanf

    ; acaba o laco se o numero for o que o usuario pensou
    mov ax, [ans]
    cmp ax, "S"
    je end_program
    cmp ax, "s"
    je end_program

    ; aumenta numero da tentativa
    inc byte [attempt_num] ; "byte" e especificado senao o codigo incrementa o valor em mais de 60000 (n sei pq)

    ; se nao for, pergunta se e maior ou menor
    mov rcx, l_or_g
    xor rdx, rdx
    call printf
    mov rcx, in_fmt
    lea rdx, [ans]
    call scanf

    ; se o usuario digitar ">" muda o valor minimo, caso contrario muda o maximo
    mov ax, [ans]
    cmp ax, ">"
    je val_is_greater
    jne val_is_lower

val_is_greater:
    ; se o valor for maior: valor minimo e salvo como numero + 1, novo numero e a media entre minimo e maximo
    mov rax, [num]
    inc rax
    mov [min], rax
    add rax, [max]
    mov rbx, 2
    xor rdx, rdx ; division doesn't work without this
    div rbx
    mov [num], rax
    jmp main_loop

val_is_lower:
    ; se o valor for menor: valor maximo e salvo como numero - 1, novo numero e a media entre minimo e maximo
    mov rax, [num]
    dec rax
    mov [max], rax
    add rax, [min]
    mov rbx, 2
    xor rdx, rdx
    div rbx
    mov [num], rax
    jmp main_loop

last_attempt:
    ; na setima e ultima tentativa so existira uma possibilidade para o valor, ela sera informada e o programa encerra
    mov rcx, f_guess
    mov rdx, [num]
    call printf
    jmp end_program

end_program:
    xor rax, rax ; codigo de saida 0 (sucesso)
    call ExitProcess