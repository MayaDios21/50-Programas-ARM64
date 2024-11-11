//============================================================
// Programa: Desplazamientos a la izquierda y derecha
// Descripción:  Realiza operaciones de desplazamiento a nivel de bits sobre un número. Muestra el valor original, el resultado después de desplazarlo a la izquierda dos posiciones y después de desplazarlo a la derecha una posición.
// Autor: Diego Enrique Maya Lopez
// Fecha: 10/11/2024
// Video: https://asciinema.org/a/RUofqSRckAcCwR024MW41GZlZ
//============================================================

// #include <stdio.h> // Biblioteca para funciones de entrada y salida

// int main() { // Función principal

//     // Declaración de variables y mensajes
//     const char* msg1 = "Valor original: %d\n"; // Mensaje para valor original
//     const char* msg2 = "Después de desplazamiento a la izquierda (x2): %d\n"; // Mensaje para desplazamiento izquierda
//     const char* msg3 = "Después de desplazamiento a la derecha (÷2): %d\n"; // Mensaje para desplazamiento derecha
//     int num = 8; // Inicializamos un número con el valor 8 (1000 en binario)
//     int resultado; // Variable para almacenar resultados de desplazamientos

//     printf(msg1, num); // Imprimir el valor original de num

//     resultado = num << 2; // Desplazamiento a la izquierda por 2 posiciones (equivalente a multiplicar por 4)
//     printf(msg2, resultado); // Imprimir resultado después de desplazamiento a la izquierda

//     resultado = num >> 1; // Desplazamiento a la derecha por 1 posición (equivalente a dividir por 2)
//     printf(msg3, resultado); // Imprimir resultado después de desplazamiento a la derecha

//     return 0; // Finalizar el programa
// }

.global main
.text

main:
    // Guardamos el link register
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Inicializamos un número para hacer los desplazamientos
    mov     x19, #8        // x19 = 8 (1000 en binario)

    // Imprimir valor original
    adr     x0, msg1
    mov     x1, x19
    bl      printf

    // Desplazamiento a la izquierda por 2 posiciones (LSL)
    lsl     x20, x19, #2     // x20 = x19 << 2
    
    // Imprimir resultado del desplazamiento a la izquierda
    adr     x0, msg2
    mov     x1, x20
    bl      printf

    // Desplazamiento a la derecha por 1 posición (LSR)
    lsr     x21, x19, #1     // x21 = x19 >> 1
    
    // Imprimir resultado del desplazamiento a la derecha
    adr     x0, msg3
    mov     x1, x21
    bl      printf

    // Restauramos el stack y retornamos
    ldp     x29, x30, [sp], #16
    mov     w0, #0
    ret

.section .rodata
msg1:
    .string "Valor original: %d\n"
msg2:
    .string "Después de desplazamiento a la izquierda (x2): %d\n"
msg3:
    .string "Después de desplazamiento a la derecha (÷2): %d\n"
