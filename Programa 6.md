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
       .section .data
    n:      .quad   10      // Número de términos a sumar
    result: .quad   0       // Resultado de la suma
    i:      .quad   1       // Contador para el bucle

    msg_n:      .ascii "Sumando los primeros "
    len_msg1:   .quad . - msg_n
    msg_result: .ascii "\nLa suma es: "
    len_msg2:   .quad . - msg_result

    .section .text
    .global _start

    _start:
    // Inicializar registros
    ldr x19, n              // x19 = N (número de términos)
    mov x20, #0             // x20 = suma (inicializada a 0)
    mov x21, #1             // x21 = i (contador, inicia en 1)

    loop:
    // Verificar si hemos llegado al final
    cmp x21, x19           
    bgt end_loop           // Si i > n, salir del bucle

    // Sumar el número actual
    add x20, x20, x21      // suma += i
    
    // Incrementar contador
    add x21, x21, #1       // i++
    
    // Repetir bucle
    b loop

    end_loop:
    // Guardar el resultado en memoria
    adr x0, result
    str x20, [x0]

    // Terminar programa
    mov x0, #0              
    mov x8, #93             
    svc #0                  

    .end
