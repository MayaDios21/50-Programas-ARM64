# Diego Enrique Maya Lopez
# Programa 3 Resta de dos números

## Video
https://asciinema.org/a/c9zeTyI0gc7KDRrNw631gnkRm

## Descripción
Este programa resta 2 numeros utilizando ensamblador ARM64.

## Programa en C

    //============================================================
    // Programa: Resta en ARM64
    // Descripción: Resta dos números 
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 6/11/2024
    //============================================================
    // Suma en C:
    // int sumar(int num1, int num2) {
    //     return num1 - num2;
    // }
## Programa en arm64
    .data
    prompt1:    .string "Ingrese el primer número: "
    prompt2:    .string "Ingrese el segundo número: "
    format_in:  .string "%ld"                    // Formato para leer enteros largos
    format_out: .string "El resultado es: %ld\n" // Formato para mostrar el resultado
    num1:       .quad 0                          // Primer número
    num2:       .quad 0                          // Segundo número
    result:     .quad 0                          // Resultado

    .text
    .global main

    main:
    // Prólogo
    stp     x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    mov     x29, sp                   // Establecer frame pointer

    // Mostrar primer prompt y leer primer número
    adr     x0, prompt1
    bl      printf

    adr     x0, format_in            // Formato para scanf
    adr     x1, num1                 // Donde guardar el número
    bl      scanf

    // Mostrar segundo prompt y leer segundo número
    adr     x0, prompt2
    bl      printf

    adr     x0, format_in            // Formato para scanf
    adr     x1, num2                 // Donde guardar el segundo número
    bl      scanf

    // Cargar números en registros
    adr     x0, num1
    ldr     x19, [x0]                // Cargar primer número
    adr     x0, num2
    ldr     x20, [x0]                // Cargar segundo número

    // Realizar la resta
    sub     x21, x19, x20            // x21 = x19 - x20

    // Guardar resultado
    adr     x0, result
    str     x21, [x0]

    // Mostrar resultado
    adr     x0, format_out           // Formato para printf
    mov     x1, x21                  // Pasar resultado como argumento
    bl      printf

    // Epílogo y retorno
    mov     w0, #0                   // Código de retorno
    ldp     x29, x30, [sp], #16      // Restaurar frame pointer y link register
    ret
