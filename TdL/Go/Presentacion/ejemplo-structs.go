package main

import "fmt"

type Vector struct {
	X int
	Y int
}

func main() {
	unVector := Vector{1, 2}
	unVector.X = 4
	
	fmt.Println(unVector.X)
}
