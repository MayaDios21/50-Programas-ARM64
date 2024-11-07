# Programa 2 Suma de dos números

## Video


## Descripción
Este programa suma 2 numeros utilizando ensamblador ARM64.

## Programa en C

    //============================================================
    // Programa: Suma en ARM64
    // Descripción: Suma dos números definidos en la sección de datos
    // Autor: Claude Assistant
    // Fecha: 6/11/2024
    //============================================================
    // Suma en C:
    // int sumar(int num1, int num2) {
    //     return num1 + num2;
    // }
## Programa en arm64
    .section .data
    num1:   .quad   125     
    num2:   .quad   37      
    result: .quad   0       

    msg_num1: .ascii "Primer número: "
    len_msg1: .quad . - msg_num1
    msg_num2: .ascii "\nSegundo número: "
    len_msg2: .quad . - msg_num2
    msg_result: .ascii "\nResultado: "
    len_msg3: .quad . - msg_result

    .section .text
    .global _start

    _start:
    // Cargar los números en registros
    ldr x19, num1           
    ldr x20, num2           

    // Realizar la suma
    add x21, x19, x20       // x21 = x19 + x20

    // Guardar el resultado en memoria
    adr x0, result
    str x21, [x0]

    // Terminar programa
    mov x0, #0              
    mov x8, #93             
    svc #0                  

    .end
