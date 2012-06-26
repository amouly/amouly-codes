package main

import "fmt"
import "math"

type Punto struct { x, y float64 }

func (p *Punto) Abs() float64 {
	return math.Sqrt(p.x*p.x + p.y*p.y)
}

type PuntoNombre struct{
	Punto
	nombre string
}

func main() {
	n := &PuntoNombre { Punto { 3, 4 }, "Pitágoras" }
	fmt.Println(n.Abs()) // Imprime 5
	fmt.Println(n.nombre)
}
