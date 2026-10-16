; ------------------------------------------------------------
; Proyecto Módulo 2 - Keygen Básico
; Fase 1: Captura del nombre y cálculo de la suma ASCII
; ------------------------------------------------------------
extrn GetStdHandle: proc
extrn WriteConsoleA: proc
extrn ReadConsoleA: proc
extrn ExitProcess: proc
.data
prompt db 'Ingresa tu nombre de usuario: ', 0
prompt_len dq $ - prompt - 1
buffer db 64 DUP (0)
buffer_len dq 64
leidos dq 0
escritos dq 0
mensaje_llave db 'Tu llave es: ', 0
mensaje_len dq $ - mensaje_llave - 1
newline db 13, 10, 0
newline_len dq $ - newline - 1
error_vacio db 'Error: nombre no valido.', 13, 10, 0
error_len dq $ - error_vacio - 1
suma dq 0
hex_chars db '0123456789ABCDEF'
hex_buffer db 17 DUP (0) ; 16 dígitos + null
.code
main proc
sub rsp, 28h
; ------------------------------------------------------------
; 1. Obtener handles de consola
; ------------------------------------------------------------
mov rcx, -11
call GetStdHandle
mov rbx, rax ; stdout
mov rcx, -10
call GetStdHandle
mov rsi, rax ; stdin
; ------------------------------------------------------------
; 2. Mostrar prompt
; ------------------------------------------------------------
mov rcx, rbx
lea rdx, prompt
mov r8, [prompt_len]
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA
; ------------------------------------------------------------
; 3. Leer nombre del usuario
; ------------------------------------------------------------
mov rcx, rsi
lea rdx, buffer
mov r8, [buffer_len]
lea r9, leidos
mov qword ptr [rsp + 20h], 0
call ReadConsoleA
; ------------------------------------------------------------
; 4. Verificar si el nombre está vacío (solo Enter)
; ------------------------------------------------------------
mov rax, [leidos]
cmp rax, 2
jle error_nombre_vacio
; ------------------------------------------------------------
; 5. TODO: Calcular la suma de los valores ASCII
; ------------------------------------------------------------
lea rsi, buffer
mov rcx, [leidos]
sub rcx, 2
xor rax, rax
suma_loop:
    movzx rdx, byte ptr [rsi]
    add rax, rdx
    inc rsi
    loop suma_loop

mov [suma], rax

; ------------------------------------------------------------
; 6. TODO: Convertir la suma a hexadecimal
; ------------------------------------------------------------
mov rax, [suma]
lea rdi, hex_buffer
add rdi, 15 ; Empezar desde el final
mov rcx, 16 ; 16 dígitos
lea r10, hex_chars
hex_loop:
    mov rdx, rax
    and rdx, 0Fh
    mov dl, [r10 + rdx]
    mov [rdi], dl
    dec rdi
    shr rax, 4
    loop hex_loop

mov byte ptr [hex_buffer + 16], 0

; ------------------------------------------------------------
; 7. TODO: Mostrar la llave en pantalla
; ------------------------------------------------------------
mov rcx, rbx         ; rbx sigue teniendo el stdout
lea rdx, mensaje_llave
mov r8, [mensaje_len]
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA

; Imprimir llave hexadecimal
mov rcx, rbx
lea rdx, hex_buffer
mov r8, 16           ; Se imprimen los 16 digitos exactos
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA

; Imprimir salto de línea
mov rcx, rbx
lea rdx, newline
mov r8, [newline_len]
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA

jmp fin
; ------------------------------------------------------------
; 8. Manejo de error: nombre vacío
; ------------------------------------------------------------
error_nombre_vacio:
mov rcx, rbx
lea rdx, error_vacio
mov r8, [error_len]
lea r9, escritos
mov qword ptr [rsp + 20h], 0
call WriteConsoleA
; ------------------------------------------------------------
; 9. Terminar
; ------------------------------------------------------------
fin:
xor ecx, ecx
call ExitProcess
main endp
end
