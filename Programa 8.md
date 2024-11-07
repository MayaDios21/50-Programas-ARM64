# Diego Enrique Maya Lopez
# Programa 8 Serie fibonacci

## Video


## Descripción
Calcula y muestra los primeros N términos de la secuencia de Fibonacci
## Programa en C
    //============================================================
    // Programa: Serie de Fibonacci
    // Descripción: Muestra los primeros N términos de la secuencia de Fibonacci
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 07/11/2024
    //============================================================
    #include <stdio.h>
    #include <stdint.h>
    #include <limits.h>

    int main() {
    int64_t num = 0;
    int64_t fib1 = 0, fib2 = 1, fib_next = 0;
    int64_t i = 1;

    // Solicitar al usuario el número de términos de Fibonacci a calcular
    printf("Ingrese el número de términos de Fibonacci a calcular: ");
    if (scanf("%ld", &num) != 1) {
        printf("Error al leer el número\n");
        return 1;
    }

    // Verificar que el número sea positivo
    if (num <= 0) {
        printf("Error: Por favor ingrese un número positivo\n");
        return 1;
    }

    // Imprimir el primer número de Fibonacci (0)
    printf("Fibonacci(%ld) = %ld\n", 0, fib1);

    // Si solo se pidió el primer término, terminar
    if (num == 1) {
        return 0;
    }

    // Imprimir el segundo número de Fibonacci (1)
    printf("Fibonacci(%ld) = %ld\n", 1, fib2);

    // Calcular e imprimir los siguientes términos de Fibonacci
    for (i = 2; i < num; ++i) {
        // Calcular el siguiente número de Fibonacci
        fib_next = fib1 + fib2;

        // Verificar si la suma causaría un desbordamiento
        if (fib_next < fib2) {
            printf("Error: El resultado es demasiado grande\n");
            return 1;
        }

        // Imprimir el siguiente término de Fibonacci
        printf("Fibonacci(%ld) = %ld\n", i, fib_next);

        // Actualizar los valores para la siguiente iteración
        fib1 = fib2;
        fib2 = fib_next;
    }

    return 0;
    }

  

## Programa en arm64

      .data
    prompt:     .string "Ingrese el número de términos de Fibonacci a calcular: "
    format_in:  .string "%ld"
    format_out: .string "Fibonacci(%ld) = %ld\n"
    error_msg:  .string "Error: Por favor ingrese un número positivo\n"
    overflow_msg: .string "Error: El resultado es demasiado grande\n"
    num:        .quad 0      // Número de términos a calcular
    fib1:       .quad 0      // Primer número de Fibonacci
    fib2:       .quad 1      // Segundo número de Fibonacci
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
    
    adr     x0, format_in            
    adr     x1, num                  
    bl      scanf

    // Cargar número en registro
    adr     x0, num
    ldr     x19, [x0]                // x19 = número de términos

    // Verificar si el número es positivo
    cmp     x19, #0
    ble     error                    // Si es <= 0, mostrar error

    // Inicializar registros para Fibonacci
    mov     x20, #0                  // x20 = fib(n-2) = 0
    mov     x21, #1                  // x21 = fib(n-1) = 1
    mov     x22, #1                  // x22 = contador = 1

    // Imprimir primer número (0)
    adr     x0, format_out
    mov     x1, #0                   // Posición 0
    mov     x2, x20                  // Valor 0
    bl      printf

    // Si solo pidieron 1 término, terminar
    cmp     x19, #1
    beq     fin

    // Imprimir segundo número (1)
    adr     x0, format_out
    mov     x1, #1                   // Posición 1
    mov     x2, x21                  // Valor 1
    bl      printf

    loop:
    // Verificar si hemos impreso todos los números
    add     x22, x22, #1            // Incrementar contador
    cmp     x22, x19
    bgt     fin                     // Si contador > n, terminar

    // Calcular siguiente número de Fibonacci
    add     x23, x20, x21           // x23 = fib(n-2) + fib(n-1)
    
    // Verificar overflow
    cmp     x23, x21
    blt     overflow                // Si nuevo < anterior, hubo overflow

    // Imprimir número actual
    adr     x0, format_out
    mov     x1, x22                 // Posición actual
    mov     x2, x23                 // Valor de Fibonacci
    bl      printf

    // Actualizar valores para siguiente iteración
    mov     x20, x21                // fib(n-2) = fib(n-1)
    mov     x21, x23                // fib(n-1) = fib(n)

    b       loop

    error:
    // Mostrar mensaje de error para número no positivo
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
