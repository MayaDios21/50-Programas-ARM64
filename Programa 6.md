# Diego Enrique Maya Lopez
# Programa 6 Suma de los N primeros números naturales

## Video
https://asciinema.org/a/xQpiFfOruciTtH1Tkz2ORlPZb

## Descripción
Este programa Suma de los N primeros números naturales en ensamblador arm64
## Programa en C

    //============================================================
    // Programa: Suma de los N primeros números naturales en ARM64
    // Descripción: Suma los primeros N números naturales usando un bucle
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 6/11/2024
    //============================================================
    // Suma en C:
    // int sumaNaturales(int n) {
    //     int suma = 0;
    //     for(int i = 1; i <= n; i++) {
    //         suma += i;
    //     }
    //     return suma;
    // }

## Programa en arm64
      .data
    prompt:     .string "Ingrese el número de términos a sumar (N): "
    format_in:  .string "%ld"
    format_out: .string "La suma de los primeros %ld números es: %ld\n"
    error_msg:  .string "Error: Por favor ingrese un número positivo\n"
    n:          .quad 0      // Número de términos a sumar
    result:     .quad 0      // Resultado de la suma
    i:          .quad 1      // Contador para el bucle

    .text
    .global main

    main:
    // Prólogo
    stp     x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    mov     x29, sp                   // Establecer frame pointer

    // Mostrar prompt y leer N
    adr     x0, prompt
    bl      printf

    adr     x0, format_in            // Formato para scanf
    adr     x1, n                    // Donde guardar N
    bl      scanf

    // Cargar N en registro
    adr     x0, n
    ldr     x19, [x0]                // x19 = N

    // Verificar si N es positivo
    cmp     x19, #0
    ble     error                    // Si N ≤ 0, mostrar error

    // Inicializar registros
    mov     x20, #0                  // x20 = suma (inicializada a 0)
    mov     x21, #1                  // x21 = i (contador, inicia en 1)

    loop:
    // Verificar si hemos llegado al final
    cmp     x21, x19           
    bgt     end_loop                 // Si i > n, salir del bucle
    
    // Sumar el número actual
    add     x20, x20, x21            // suma += i
    
    // Incrementar contador
    add     x21, x21, #1             // i++
    
    // Repetir bucle
    b       loop

    end_loop:
    // Guardar el resultado en memoria
    adr     x0, result
    str     x20, [x0]

    // Mostrar resultado
    adr     x0, format_out           // Formato para printf
    mov     x1, x19                  // N como primer argumento
    mov     x2, x20                  // suma como segundo argumento
    bl      printf
    b       fin

    error:
    // Mostrar mensaje de error
    adr     x0, error_msg
    bl      printf

    fin:
    // Epílogo y retorno
    mov     w0, #0                   // Código de retorno
    ldp     x29, x30, [sp], #16      // Restaurar frame pointer y link register
    ret
