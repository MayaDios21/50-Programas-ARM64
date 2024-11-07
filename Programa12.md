## Diego Enrique Maya Lopez 
## Programa 12 Encontrar el máximo en un arreglo

## Video
https://asciinema.org/a/DwAwo51Q3yqUBkRxbw7kY6IxL

## Descripcion 
En este programa se introduce un arreglo de numeros con limite de 100 numeros en el cual encontrara el valor mas grande de los introducidos 

## Programa en C
    //============================================================
    // Programa: Programa 12 Encontrar el maximo en un arreglo
    // Descripción: Encuentra el numero mas alto introducido
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 07/11/2024
    #include <stdio.h>
    int main() {
    char pregunta_tam[] = "¿Cuántos números deseas introducir? (máximo 100): ";
    char pedir_num[] = "Introduce el número %ld: ";
    char mensaje_max[] = "El valor máximo es: %ld\n";
    long arreglo[100];  // Espacio para hasta 100 números
    long tam;           // Variable para almacenar el tamaño del arreglo

    // Pedir tamaño del arreglo
    printf("%s", pregunta_tam);
    scanf("%ld", &tam);

    // Validar que el tamaño esté dentro del límite
    if (tam > 100) {
        printf("Error: El tamaño máximo permitido es 100.\n");
        return 1;
    }

    // Leer los números
    for (long i = 0; i < tam; i++) {
        printf(pedir_num, i + 1);
        scanf("%ld", &arreglo[i]);
    }

    // Encontrar el valor máximo
    long max = arreglo[0];
    for (long i = 1; i < tam; i++) {
        if (arreglo[i] > max) {
            max = arreglo[i];
        }
    }

    // Imprimir el valor máximo
    printf(mensaje_max, max);

    return 0;
    }


## Programa en ARM64 
    .data
    pregunta_tam: .string "¿Cuántos números deseas introducir? (máximo 100): "
    formato_tam: .string "%ld"
    pedir_num: .string "Introduce el número %ld: "
    formato_num: .string "%ld"
    mensaje_max: .string "El valor máximo es: %ld\n"
    
    // Buffer para almacenar los números
    .align 8
    arreglo: .skip 800          // Espacio para 100 números (100 * 8 bytes)
    tam: .quad 0                // Variable para almacenar el tamaño del arreglo

    .global main
    .text

    main:
    // Prólogo
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Pedir tamaño del arreglo
    adr x0, pregunta_tam
    bl printf

    // Leer tamaño
    adr x0, formato_tam
    adr x1, tam
    bl scanf

    // Limpiar el buffer de entrada
    bl getchar

    // Cargar el tamaño en x19
    adr x0, tam
    ldr x19, [x0]               // x19 = tamaño del arreglo

    // Inicializar contador en x20
    mov x20, #0                 // x20 = contador

    leer_numeros:
    // Verificar si hemos terminado
    cmp x20, x19
    b.ge encontrar_max

    // Imprimir mensaje para pedir número
    adr x0, pedir_num
    add x1, x20, #1            // Número actual + 1 para mostrar
    bl printf

    // Leer número
    adr x0, formato_num
    adr x1, arreglo
    add x1, x1, x20, lsl #3    // Calcular dirección del elemento actual
    bl scanf

    // Limpiar el buffer de entrada
    bl getchar

    // Incrementar contador
    add x20, x20, #1
    b leer_numeros

    encontrar_max:
    // Inicializar con el primer elemento como máximo
    adr x0, arreglo
    ldr x21, [x0]              // x21 = máximo actual
    mov x20, #1                // x20 = índice para búsqueda

    bucle_max:
    cmp x20, x19
    b.ge imprimir_resultado

    // Cargar siguiente número
    adr x0, arreglo
    add x0, x0, x20, lsl #3
    ldr x22, [x0]              // x22 = número actual

    // Comparar con máximo
    cmp x22, x21
    b.le no_actualizar
    mov x21, x22               // Actualizar máximo si es mayor

    no_actualizar:
    add x20, x20, #1
    b bucle_max

    imprimir_resultado:
    // Imprimir el máximo
    adr x0, mensaje_max
    mov x1, x21
    bl printf

    // Epílogo y retorno
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret
