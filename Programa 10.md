## Diego Enrique Maya Lopez 
## Programa 10 Invertir una cadena

## Video
https://asciinema.org/a/JVGHkbUAreFVhDk9MVPgGU3sm

## Descripcion 
Al introducir un texto este lo invertira de tal manera que si escribe "Hola" se entregara como "aloH"
## Programa en C
    //============================================================
    // Programa: Invertir una cadena
    // Descripción: Invierte una cadena de texto
    // Autor: Diego Enrique Maya Lopez
    // Fecha: 07/11/2024
    #include <stdio.h>
    #include <string.h>

    int main() {
    char str[256];

    // Solicitar la cadena de texto
    printf("Ingresa una cadena de texto: ");
    scanf("%255s", str);

    // Encontrar el final de la cadena (longitud)
    int length = strlen(str);

    // Invertir la cadena
    for (int i = 0, j = length - 1; i < j; i++, j--) {
        // Intercambiar los caracteres en las posiciones i y j
        char temp = str[i];
        str[i] = str[j];
        str[j] = temp;
    }

    // Imprimir la cadena invertida
    printf("La cadena invertida es: %s\n", str);

    return 0;
    }
## Porgrama en ARM64

