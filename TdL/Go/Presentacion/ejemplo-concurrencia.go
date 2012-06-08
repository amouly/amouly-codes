package main

import "fmt"

func suma(laLista []int, elCanal chan int) {
	sum := 0
	
	/* Suma los elementos de la lista */
	for _, v := range laLista {
		sum += v
	}
	
	/* Envía la suma por el canal */
	elCanal <- sum
}

func main() {
	unaLista := []int{7, 2, 8, -9, 4, 0}

	/* Creo un canal */
	unCanal := make(chan int)
	
	/* Creo dos Goroutines */
	go suma(unaLista[:len(unaLista)/2], unCanal)
	go suma(unaLista[len(unaLista)/2:], unCanal)
	
	/* Recibo la información del canal (esta encolada) y la asigno */
    x, y := <-unCanal, <-unCanal

	fmt.Println(x, y, x + y)
}
