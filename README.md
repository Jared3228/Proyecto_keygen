# Proyecto_keygen

Nombre del alumno: Leonardo Jared Ley Gomez

## Descripción del proyecto

El siguiente proyecto en ensamblador es un generador de llaves o "keys", tomando como base el input del usuario. Pide un nombre y el código calcula la suma de sus caracteres en ASCII, posteriormente transforma la suma acumulada a hexadecimal e imprime el resultado "key" de 16 dígitos. 

## Compilación

Ensamble:
```
uasm64 -win64 [nombre_del_archivo].asm 
```

Enlazamiento:
```
golink [nombre_del_archivo].obj kernel32.dll /fo [nombre_del_archivo].exe /console /entry main
```

## Ejecución

Comando para ejecución en consola:
´´´
.\[nombre_del_archivo].exe
´´´

Instrucciones:

1. Ejecutar el programa
2. Escribir nuestro nombre
3. Listo, se nos devolverá nuestra "key" en formato hexadecimal

<img width="447" height="49" alt="ejecucion" src="https://github.com/user-attachments/assets/dc71a0b3-f0d0-407d-81a3-abd4fa6d38fe" />

Nota: En caso de no haber escrito nada el programa devolverá el mensaje de error "Nombre no valido"

<img width="447" height="44" alt="Captura de pantalla 2026-10-15 233811" src="https://github.com/user-attachments/assets/c1710e20-149a-44ee-9ea9-760ee7c1f50a" />

# Explicación del algoritmo de generación de llave

El algoritmo recorre la cadena de texto dada por el usuario, suma los valores de los caracteres ASCII y a la suma acumulada la convierte a hexadecimal.
