//============================================================
// Programa: Potencia (x^n)
// Descripción: Se despliega un numero elevado "x" a la "n" veces
// Autor: Diego Enrique Maya Lopez
// Fecha: 07/11/2024
// Video:
//============================================================

// #include <stdio.h> // Biblioteca estándar para funciones de entrada y salida

// int main() { // Función principal

//     // Inicializar variables
//     int base = 2; // Base para la potencia (2)
//     int exponente = 5; // Exponente (5)
//     int resultado = 1; // Resultado inicializado en 1, usado para calcular la potencia
//     int exponente_original = exponente; // Guardar el valor original del exponente

//     // Si el exponente es 0, el resultado es 1
//     if (exponente == 0) { // Verificar si el exponente es cero
//         printf("%d^%d = %d\n", base, exponente_original, resultado); // Imprimir el resultado (1)
//         return 0; // Salir del programa
//     }

//     // Bucle para calcular la potencia
//     while (exponente > 0) { // Continuar mientras el exponente sea mayor que cero
//         resultado *= base; // Multiplicar el resultado por la base
//         exponente--; // Disminuir el exponente en 1
//     }

//     // Imprimir el resultado final
//     printf("%d^%d = %d\n", base, exponente_original, resultado); // Imprimir el cálculo final

//     return 0; // Finalizar el programa
// }


.global main
.data
format: .asciz "%d^%d = %d\n"    // Cambiado a .asciz para null-termination automática

.text
main:
    // Guardar registros
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Guardar registros que usaremos
    stp     x19, x20, [sp, -16]!
    stp     x21, x22, [sp, -16]!

    // Inicializar valores
    mov     x19, #2                 // base = 2
    mov     x20, #5                 // exponente = 5
    mov     x21, #1                 // resultado = 1
    mov     x22, x20               // guardar exponente original

    // Si el exponente es 0, saltar al final
    cbz     x20, print_result

loop:
    // Multiplicar resultado por base
    mul     x21, x21, x19          // resultado *= base
    
    // Decrementar contador y continuar si no es cero
    subs    x20, x20, #1           // exponente--
    b.ne    loop                   // si no es cero, continuar loop

print_result:
    // Imprimir resultado
    adrp    x0, format
    add     x0, x0, :lo12:format
    mov     x1, x19                // base
    mov     x2, x22                // exponente original
    mov     x3, x21                // resultado
    bl      printf

    // Restaurar registros
    ldp     x21, x22, [sp], 16
    ldp     x19, x20, [sp], 16
    
    // Retornar
    mov     x0, 0
    ldp     x29, x30, [sp], 16
    ret
