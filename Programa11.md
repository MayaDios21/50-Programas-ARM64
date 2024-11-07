## Diego Enrique Maya Lopez
## Programa 11 Verificar si una cadena es palíndromo

## Video
https://asciinema.org/a/tiXZPki0LICXgFPyZNKEu1pF5

## Descripcion
En el progama se verifica si es un palindromo la palabra introducida

## Programa en C
    //============================================================
    // Programa: Verificar si una cadena es palíndromo
    // Descripción: Verifica si una cadena de texto es un palindromo o no
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 07/11/2024
    #include <stdio.h>
    #include <string.h>

    // Función para verificar si una cadena es un palíndromo
    // Retorna 1 si es palíndromo, 0 si no lo es
    int is_palindrome(char *str, int length) {
    int start = 0;
    int end = length - 1;

    while (start < end) {
        if (str[start] != str[end]) {
            return 0; // No es palíndromo
        }
        start++;
        end--;
    }
    return 1; // Es palíndromo
    }

    int main() {
    char prompt[] = "Introduce una palabra: ";
    char str_palindrome[] = "Es palindromo\n";
    char str_not_palindrome[] = "No es palindromo\n";
    char buffer[100];  // Buffer para almacenar la entrada del usuario

    // Imprimir prompt
    printf("%s", prompt);

    // Leer entrada del usuario
    scanf("%99s", buffer);

    // Calcular longitud de la cadena introducida
    int length = strlen(buffer);

    // Verificar si es palíndromo
    if (is_palindrome(buffer, length)) {
        printf("%s", str_palindrome);
    } else {
        printf("%s", str_not_palindrome);
    }

    return 0;
    }  

## Programa en ARM64

    .data
    prompt:          .string "Introduce una palabra: "
    str_palindrome:  .string "Es palindromo\n"
    str_not_palindrome: .string "No es palindromo\n"
    format_string:   .string "%s"
    buffer:          .skip 100       // Buffer para almacenar la entrada del usuario

    .text
    .global main

    main:
    // Prólogo
    stp     x29, x30, [sp, #-16]!   // Guardar frame pointer y link register
    mov     x29, sp

    // Imprimir prompt
    adr     x0, prompt
    bl      printf

    // Leer entrada del usuario
    adr     x0, format_string       // Formato para scanf
    adr     x1, buffer              // Buffer donde se guardará la entrada
    bl      scanf

    // Limpiar el buffer de entrada
    bl      getchar                 // Limpiar el carácter newline


    // Calcular longitud de la cadena introducida
    adr     x0, buffer
    bl      strlen                  // Llamar función strlen
    mov     x19, x0                 // Guardar longitud en x19

    // Preparar parámetros para verificar palíndromo
    adr     x0, buffer             // x0 = dirección de la cadena
    mov     x1, x19                // x1 = longitud de la cadena
    bl      is_palindrome          // Llamar a la función is_palindrome

    // Verificar resultado
    cbnz    w0, print_palindrome   // Si resultado != 0, es palíndromo

    print_not_palindrome:
    adr     x0, str_not_palindrome
    bl      printf
    b       end

    print_palindrome:
    adr     x0, str_palindrome
    bl      printf

    end:
    // Epílogo
    ldp     x29, x30, [sp], #16    // Restaurar frame pointer y link register
    mov     w0, #0                 // Retornar 0
    ret

    // Función para verificar si es palíndromo
    // x0 = dirección de la cadena
    // x1 = longitud de la cadena
    // Retorna: 1 si es palíndromo, 0 si no lo es
    is_palindrome:
    stp     x29, x30, [sp, #-16]!  // Guardar registros
    mov     x29, sp

    mov     x2, x0                 // x2 = inicio de la cadena
    add     x3, x0, x1             // x3 = fin de la cadena
    sub     x3, x3, #1             // Ajustar para índice base 0

    compare_loop:
    cmp     x2, x3                 // Comparar punteros
    b.ge    is_palindrome_true     // Si se cruzaron, es palíndromo

    ldrb    w4, [x2]               // Cargar carácter del inicio
    ldrb    w5, [x3]               // Cargar carácter del final

    cmp     w4, w5                 // Comparar caracteres
    b.ne    is_palindrome_false    // Si son diferentes, no es palíndromo
    add     x2, x2, #1             // Mover puntero inicio
    sub     x3, x3, #1             // Mover puntero final
    b       compare_loop

    is_palindrome_true:
    mov     w0, #1                 // Retornar 1 (verdadero)
    b       is_palindrome_end

    is_palindrome_false:
    mov     w0, #0                 // Retornar 0 (falso)

    is_palindrome_end:
    ldp     x29, x30, [sp], #16    // Restaurar registros
    ret
