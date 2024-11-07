# Programa 1 Convertir temperatura de Celsius a Fahrenheit

## Video


## Descripción
Este programa convierte una temperatura dada en grados Celsius a Fahrenheit utilizando ensamblador ARM64.

## Código en C
```c
// Conversión en C:
float celsius_a_fahrenheit(float celsius) {
    return (celsius * 9.0 / 5.0) + 32.0;
}


## Código en ARM64

//============================================================
// Programa: Conversion Celsius a Fahrenheit en ARM64
// Descripción: Convierte una temperatura dada en grados Celsius a Fahrenheit
// Autor: [Tu Nombre]
// Fecha: [Fecha]
//============================================================

.section .data
input_celsius: .float 25.0    // Temperatura en Celsius de ejemplo (modifica según necesidad)
result_fahrenheit: .float 0.0  // Resultado en Fahrenheit

.section .text
.global _start

_start:
    // Cargar el valor de Celsius en el registro de coma flotante s0
    ldr s0, =input_celsius
    ldr s0, [s0]

    // Multiplicar celsius por 9.0 (s0 = s0 * 9.0)
    fmov s1, #9.0
    fmul s0, s0, s1

    // Dividir el resultado por 5.0 (s0 = s0 / 5.0)
    fmov s1, #5.0
    fdiv s0, s0, s1

    // Sumar 32.0 al resultado (s0 = s0 + 32.0)
    fmov s1, #32.0
    fadd s0, s0, s1

    // Guardar el resultado en la variable result_fahrenheit
    ldr x1, =result_fahrenheit
    str s0, [x1]

    // Finalizar el programa
    mov x0, #0      // status 0
    mov x8, #93     // syscall exit en ARM64
    svc 0

