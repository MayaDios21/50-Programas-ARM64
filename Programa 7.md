# Diego Enrique Maya Lopez
# Programa 7 Factorial de un número

## Video
https://asciinema.org/a/FgEYYaHyvGEuLpCEMRw2kth1W

## Descripción
Este programa calcula el factorial de un número dado, con verificación para evitar el desbordamiento de enteros y para asegurar que el número es no negativo.
## Programa en C

    //============================================================
    // Programa: Suma de los N primeros números naturales en ARM64
    // Descripción: Calcula el factorial de un número dado
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 07/11/2024
    //============================================================
    #include <stdio.h>
    #include <stdint.h>
    #include <limits.h>

    int main() {
    int64_t num = 0;
    int64_t result = 1;
    int64_t i = 1;

    // Solicitar al usuario el número para calcular su factorial
    printf("Ingrese un número para calcular su factorial: ");
    if (scanf("%ld", &num) != 1) {
        printf("Error al leer el número\n");
        return 1;
    }

    // Verificar que el número no sea negativo
    if (num < 0) {
        printf("Error: Por favor ingrese un número no negativo\n");
        return 1;
    }

    // Calcular el factorial, con verificación de desbordamiento
    for (i = 1; i <= num; ++i) {
        // Comprobar si la multiplicación causaría un desbordamiento
        if (result > LLONG_MAX / i) {
            printf("Error: El resultado es demasiado grande\n");
            return 1;
        }
        result *= i;
    }

    // Imprimir el resultado del factorial
    printf("El factorial de %ld es: %ld\n", num, result);
    return 0;
    }

## Programa en arm64

    .data
    prompt:     .string "Ingrese un número para calcular su factorial: "
    format_in:  .string "%ld"
    format_out: .string "El factorial de %ld es: %ld\n"
    error_msg:  .string "Error: Por favor ingrese un número no negativo\n"
    overflow_msg: .string "Error: El resultado es demasiado grande\n"
    num:        .quad 0      // Número de entrada
    result:     .quad 1      // Resultado del factorial
    i:          .quad 1      // Contador para el bucle

    .text
    .global main

    main:
    // Prólogo
    stp     x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    mov     x29, sp                   // Establecer frame pointer

    // Mostrar prompt y leer número
    adr     x0, prompt
    bl      printf

    adr     x0, format_in            // Formato para scanf
    adr     x1, num                  // Donde guardar el número
    bl      scanf

    // Cargar número en registro
    adr     x0, num
    ldr     x19, [x0]                // x19 = número de entrada

    // Verificar si el número es negativo
    cmp     x19, #0
    blt     error                    // Si es negativo, mostrar error

    // Inicializar registros
    mov     x20, #1                  // x20 = resultado (inicializado a 1)
    mov     x21, #1                  // x21 = i (contador, inicia en 1)

    loop:
    // Verificar si hemos llegado al número
    cmp     x21, x19           
    bgt     end_loop                 // Si i > número, salir del bucle
    
    // Multiplicar por el número actual
    mul     x22, x20, x21            // temporal = resultado * i
    
    // Verificar overflow comparando con el resultado anterior
    cmp     x22, x20
    blt     overflow                 // Si el nuevo resultado es menor, hubo overflow
    
    mov     x20, x22                 // resultado = temporal
    
    // Incrementar contador
    add     x21, x21, #1             // i++
    
    // Repetir bucle
    b       loop

    end_loop:
    // Guardar el resultado
    adr     x0, result
    str     x20, [x0]

    // Mostrar resultado
    adr     x0, format_out           // Formato para printf
    mov     x1, x19                  // número como primer argumento
    mov     x2, x20                  // factorial como segundo argumento
    bl      printf
    b       fin

    error:
    // Mostrar mensaje de error para número negativo
    adr     x0, error_msg
    bl      printf
    b       fin

    overflow:
    // Mostrar mensaje de error por overflow
    adr     x0, overflow_msg
    bl      printf

    fin:
    // Epílogo y retorno
    mov     w0, #0                   // Código de retorno
    ldp     x29, x30, [sp], #16      // Restaurar frame pointer y link register
    ret
