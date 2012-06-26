package main

import "fmt"

type Vector struct {
	Lat, Long float64
}

var m map[string]Vector

func main() {
	m = make(map[string]Vector)

	m["FIUBA"] = Vector{ -34.617639, -58.368497 }

	fmt.Println(m["FIUBA"])
}
