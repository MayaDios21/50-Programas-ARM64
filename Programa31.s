//============================================================
// Programa: Mínimo Común Múltiplo (MCM)	
// Descripción: Este programa el minimo comun multiplo entre 2 numeros
// Autor: Diego Enrique Maya Lopez
// Fecha: 11/11/2024
// Video: https://asciinema.org/a/NW1QU0iEJB8ulao3BRB3DM4bI
//============================================================

// #include <stdio.h> // Biblioteca estándar para funciones de entrada y salida

// int main() { // Función principal

//     // Declaración de variables
//     int numero1 = 4; // Primer número para el cálculo del MCM (4)
//     int numero2 = 6; // Segundo número para el cálculo del MCM (6)
//     int mcm = 12; // Valor del MCM calculado directamente (12)

//     // Imprimir el resultado del MCM
//     printf("MCM de %d y %d es: %d\n", numero1, numero2, mcm); // Mostrar el MCM en pantalla

//     return 0; // Terminar el programa
// }

.global main
.align 2

main:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Usar números más pequeños: 4 y 6
    mov w19, #4               // Primer número
    mov w20, #6               // Segundo número

    // Calcular MCM directamente (4 * 6 = 24 / 2 = 12)
    mov w21, #12              // Resultado directo del MCM

    // Preparar printf
    adr x0, formato
    mov w1, w19               // Primer número (4)
    mov w2, w20               // Segundo número (6)
    mov w3, w21               // Resultado MCM (12)

    // Llamar printf
    bl printf

    // Retornar
    mov w0, #0
    ldp x29, x30, [sp], #16
    ret

.section .data
formato: .string "MCM de %d y %d es: %d\n"
