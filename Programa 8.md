# Diego Enrique Maya Lopez
# Programa 8 Serie fibonacci

## Video


## Descripción
Calcula y muestra los primeros N términos de la secuencia de Fibonacci
## Programa en C
    
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

  
