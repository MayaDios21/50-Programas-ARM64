//============================================================
// Programa: Leer entrada desde el teclado
// Descripción: Este programa solicita al usuario que ingrese un texto,lo almacena en un buffer y luego lo muestra en pantalla. 
// Si ocurre un error durante la lectura, se muestra un mensaje de error. 
// Autor: Diego Enrique Maya Lopez
// Fecha: 19/11/2024
// Video: https://asciinema.org/a/70ILXXfyJVDZKScK40YEpF2SW
//============================================================
/*
#include <stdio.h>

int main() {
    char input[100]; // Buffer para almacenar la entrada del usuario

    // Mostrar prompt al usuario
    printf("🖊️  Por favor, ingrese un texto: ");

    // Leer la entrada del usuario
    if (scanf("%[^\n]", input) != 1) {
        // Si ocurre un error, mostrar mensaje y retornar código de error
        printf("❌ Error al leer la entrada\n");
        return 1;
    }

    // Mostrar lo que se leyó
    printf("📝 Usted escribió: %s\n", input);

    return 0; // Retorno exitoso
}
*/

.data
    prompt: .asciz "🖊️  Por favor, ingrese un texto: "
    input: .space 100       // Buffer para almacenar la entrada (100 bytes)
    formato: .asciz "%[^\n]" // Formato para scanf que lee hasta encontrar un newline
    output: .asciz "📝 Usted escribió: %s\n"
    error_msg: .asciz "❌ Error al leer la entrada\n"

.text
.global main
.extern printf
.extern scanf
.extern gets
.extern puts

main:
    // Prólogo
    stp x29, x30, [sp, -16]!
    mov x29, sp
    
    // Mostrar prompt
    adrp x0, prompt
    add x0, x0, :lo12:prompt
    bl printf
    
    // Leer entrada usando scanf
    adrp x0, formato
    add x0, x0, :lo12:formato    // Primer argumento: formato
    adrp x1, input
    add x1, x1, :lo12:input      // Segundo argumento: buffer
    bl scanf
    
    // Verificar si scanf fue exitoso
    cmp x0, #1
    bne error_reading
    
    // Mostrar lo que se leyó
    adrp x0, output
    add x0, x0, :lo12:output
    adrp x1, input
    add x1, x1, :lo12:input
    bl printf
    
    // Epílogo y retorno exitoso
    mov w0, #0
    ldp x29, x30, [sp], #16
    ret
    
error_reading:
    // Mostrar mensaje de error
    adrp x0, error_msg
    add x0, x0, :lo12:error_msg
    bl printf
    
    // Retornar con código de error
    mov w0, #1
    ldp x29, x30, [sp], #16
    ret
