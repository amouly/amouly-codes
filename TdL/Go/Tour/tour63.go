package main

import "fmt"

func sum(laLista []int, elCanal chan int) {
	sum := 0
	
	for _, v := range laLista {
		sum += v
	}
	
	elCanal <- sum  // Envía la suma por el canal
}

func main() {
	unaLista := []int{7, 2, 8, -9, 4, 0}

	unCanal := make(chan int)
	
	go sum(unaLista[:len(unaLista)/2], unCanal)
	go sum(unaLista[len(unaLista)/2:], unCanal)
	
    x, y := <-unCanal, <-unCanal  // Recibo la información del canal y la asigno

	fmt.Println(x, y, x + y)
}
