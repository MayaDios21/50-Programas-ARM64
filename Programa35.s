//============================================================
// Programa: Rotación de un arreglo (izquierda/derecha)
// Descripción: 
// Autor: Diego Enrique Maya Lopez
// Fecha: 11/11/2024
// Video:
//============================================================

.section .rodata
format_original: .asciz "\nArreglo original:\n"
format_izquierda: .asciz "\nArreglo rotado a la izquierda %d posiciones:\n"
format_derecha: .asciz "\nArreglo rotado a la derecha %d posiciones:\n"
format_elemento: .asciz "%d "
format_newline: .asciz "\n"

.section .data
array: .word 1, 2, 3, 4, 5, 6, 7, 8    // Arreglo de 8 elementos
array_size: .word 8                     // Tamaño del arreglo
rotaciones: .word 3                     // Número de posiciones a rotar
temp_array: .zero 32                    // Array temporal (8 elementos * 4 bytes)

.text
.global main
.type main, %function

// Función para imprimir el arreglo
print_array:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    stp     x19, x20, [sp, -16]!
    
    mov     x19, x0                // Dirección del arreglo
    mov     x20, x1                // Tamaño del arreglo
    mov     x21, #0                // Contador
    
print_loop:
    cmp     x21, x20
    b.ge    print_end
    
    // Imprimir elemento actual
    adrp    x0, format_elemento
    add     x0, x0, :lo12:format_elemento
    ldr     w1, [x19, x21, lsl #2]
    bl      printf
    
    add     x21, x21, #1
    b       print_loop
    
print_end:
    // Imprimir nueva línea
    adrp    x0, format_newline
    add     x0, x0, :lo12:format_newline
    bl      printf
    
    ldp     x19, x20, [sp], 16
    ldp     x29, x30, [sp], 16
    ret

// Función principal
main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    stp     x19, x20, [sp, -16]!
    stp     x21, x22, [sp, -16]!
    
    // Cargar direcciones y valores
    adrp    x19, array
    add     x19, x19, :lo12:array          // x19 = dirección del arreglo
    adrp    x20, array_size
    add     x20, x20, :lo12:array_size
    ldr     w20, [x20]                     // w20 = tamaño
    adrp    x21, rotaciones
    add     x21, x21, :lo12:rotaciones
    ldr     w21, [x21]                     // w21 = número de rotaciones
    adrp    x22, temp_array
    add     x22, x22, :lo12:temp_array     // x22 = arreglo temporal
    
    // Imprimir arreglo original
    adrp    x0, format_original
    add     x0, x0, :lo12:format_original
    bl      printf
    
    mov     x0, x19                // Dirección del arreglo
    mov     x1, x20                // Tamaño
    bl      print_array
    
    // Rotación a la izquierda
    // Primero copiamos el arreglo original al temporal
    mov     x23, #0                // Contador
copy_left:
    cmp     x23, x20
    b.ge    do_left_rotation
    ldr     w24, [x19, x23, lsl #2]
    str     w24, [x22, x23, lsl #2]
    add     x23, x23, #1
    b       copy_left
    
do_left_rotation:
    // Realizar la rotación
    mov     x23, #0                // Contador
left_rotate:
    cmp     x23, x20
    b.ge    print_left_result
    
    add     x24, x23, x21         // índice + rotaciones
    udiv    x25, x24, x20         // división para wrap-around
    msub    x24, x25, x20, x24    // módulo para wrap-around
    
    ldr     w25, [x22, x23, lsl #2]
    str     w25, [x19, x24, lsl #2]
    
    add     x23, x23, #1
    b       left_rotate
    
print_left_result:
    adrp    x0, format_izquierda
    add     x0, x0, :lo12:format_izquierda
    mov     w1, w21
    bl      printf
    
    mov     x0, x19
    mov     x1, x20
    bl      print_array
    
    // Rotación a la derecha
    // Primero restauramos el arreglo original
    mov     x23, #0
copy_right:
    cmp     x23, x20
    b.ge    do_right_rotation
    ldr     w24, [x22, x23, lsl #2]
    str     w24, [x19, x23, lsl #2]
    add     x23, x23, #1
    b       copy_right
    
do_right_rotation:
    mov     x23, #0
right_rotate:
    cmp     x23, x20
    b.ge    print_right_result
    
    sub     x24, x20, x21         // tamaño - rotaciones
    add     x24, x24, x23         // + índice actual
    udiv    x25, x24, x20         // división para wrap-around
    msub    x24, x25, x20, x24    // módulo para wrap-around
    
    ldr     w25, [x22, x23, lsl #2]
    str     w25, [x19, x24, lsl #2]
    
    add     x23, x23, #1
    b       right_rotate
    
print_right_result:
    adrp    x0, format_derecha
    add     x0, x0, :lo12:format_derecha
    mov     w1, w21
    bl      printf
    
    mov     x0, x19
    mov     x1, x20
    bl      print_array
    
    // Epílogo
    ldp     x21, x22, [sp], 16
    ldp     x19, x20, [sp], 16
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

.size main, .-main
