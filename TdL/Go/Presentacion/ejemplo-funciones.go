package main

/* Importo funciones de I/O */
import "fmt"

/* Se pueden omitir los tipos consecutivos */
func suma(x, y int) int {
	return x + y
}

/* Una función puede retornar multiples valores */
func swap(x, y string) (string, string) {
	return y, x
}

func main() {
	
	fmt.Println(suma(42, 13))
	
	a, b := swap("Hola", "FIUBA")
	fmt.Println(a, b)
}
