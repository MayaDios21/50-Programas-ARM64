## Diego Enrique Maya Lopez 
## Programa 13 Encuentra el minimo en un arreglo

## Video


## Descripcion 
En un arreglo de numeros no ordenados encuentra el numero menor entre ellos

## Programa en C
    //============================================================
    // Programa: 
    // Descripción: 
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 07/11/2024
    #include <stdio.h>
    int main() {
    // Inicializar el arreglo y su longitud
    long arreglo[] = {15, 7, 23, 9, 12, 3, 18, 45, 6, 11};
    int longitud = 10;

    // Imprimir mensaje inicial
    printf("Arreglo: ");
    
    // Imprimir todos los elementos del arreglo
    for (int i = 0; i < longitud; i++) {
        printf("%ld ", arreglo[i]);
    }
    printf("\n");

    // Encontrar el mínimo
    long minimo = arreglo[0];
    for (int i = 1; i < longitud; i++) {
        if (arreglo[i] < minimo) {
            minimo = arreglo[i];
        }
    }

    // Imprimir el mínimo
    printf("\nEl mínimo es: %ld\n", minimo);

    return 0;
    }


## Programa en ARM64   
    .data
    arreglo:    .quad   15, 7, 23, 9, 12, 3, 18, 45, 6, 11  // Arreglo de números
    longitud:   .quad   10                                   // Longitud del arreglo
    msg_arr:    .asciz  "Arreglo: "
    msg_num:    .asciz  "%ld "                              // Formato para imprimir números
    msg_min:    .asciz  "\nEl mínimo es: %ld\n"            // Mensaje para el mínimo
    newline:    .asciz  "\n"

    .text
    .global main
    main:
    // Prólogo
    stp     x29, x30, [sp, -48]!
    mov     x29, sp

    // Imprimir mensaje inicial
    ldr     x0, =msg_arr
    bl      printf

    // Inicializar variables
    ldr     x19, =arreglo         // x19 = dirección base del arreglo
    ldr     x20, =longitud        // Cargar dirección de longitud
    ldr     x20, [x20]            // x20 = longitud del arreglo
    mov     x21, #0               // x21 = contador (i)
    
    // Imprimir todos los números del arreglo
    print_loop:
    cmp     x21, x20
    bge     print_done            // Si i >= longitud, terminar impresión
    
    // Imprimir número actual
    ldr     x0, =msg_num
    ldr     x1, [x19, x21, lsl #3]  // Cargar arreglo[i]
    bl      printf
    
    add     x21, x21, #1         // i++
    b       print_loop
    
    print_done:
    // Inicializar mínimo con el primer elemento
    ldr     x22, [x19]           // x22 = mínimo = arreglo[0]
    mov     x21, #1              // x21 = contador = 1 (empezamos desde el segundo elemento)

    find_min_loop:
    cmp     x21, x20
    bge     find_min_done        // Si i >= longitud, terminar búsqueda
    
    // Cargar elemento actual
    ldr     x23, [x19, x21, lsl #3]  // x23 = arreglo[i]
    
    // Comparar con el mínimo actual
    cmp     x23, x22
    bge     not_smaller          // Si arreglo[i] >= mínimo, continuar
    mov     x22, x23             // Si arreglo[i] < mínimo, actualizar mínimo
    
    not_smaller:
    add     x21, x21, #1         // i++
    b       find_min_loop

    find_min_done:
    // Imprimir el mínimo
    ldr     x0, =msg_min
    mov     x1, x22
    bl      printf

    // Epílogo y retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 48
    ret
