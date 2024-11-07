# Programa 5 Division de dos números

## Video


## Descripción
Este programa divide 2 numeros utilizando ensamblador ARM64.

## Programa en C

    //============================================================
    // Programa: Resta en ARM64
    // Descripción: Resta dos números 
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 6/11/2024
    //============================================================
    // Suma en C:
    // int sumar(int num1, int num2) {
    //     return num1 / num2;
    // }
## Programa en arm64
    .section .data
    num1:   .quad   125     
    num2:   .quad   37      
    result: .quad   0       
    resto:  .quad   0       // Para almacenar el resto de la división

    msg_num1: .ascii "Primer número: "
    len_msg1: .quad . - msg_num1
    msg_num2: .ascii "\nSegundo número: "
    len_msg2: .quad . - msg_num2
    msg_result: .ascii "\nResultado: "
    len_msg3: .quad . - msg_result
    msg_resto: .ascii "\nResto: "
    len_msg4: .quad . - msg_resto

    .section .text
    .global _start

    _start:
    // Cargar los números en registros
    ldr x19, num1           
    ldr x20, num2           

    // Verificar división por cero
    cmp x20, #0
    beq exit                // Si el divisor es 0, salir del programa

    // Realizar la división
    sdiv x21, x19, x20      // x21 = x19 / x20 (cociente)
    
    // Calcular el resto
    msub x22, x21, x20, x19 // x22 = x19 - (x21 * x20) (resto)

    // Guardar el resultado y resto en memoria
    adr x0, result
    str x21, [x0]
    adr x0, resto
    str x22, [x0]

    exit:
    // Terminar programa
    mov x0, #0              
    mov x8, #93             
    svc #0                  

    .end
