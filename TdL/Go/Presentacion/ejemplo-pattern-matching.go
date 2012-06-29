package main

import "fmt"

/* Al definir un trait, va a ser madre de otros tipos. */
type Expr trait {}

/* Defino 3 subtipos de Expr. */
type Constante casestruct borrows Expr {
    value  int
}

type Variable casestruct borrows Expr {
    name   string
}

type Multiple casestruct borrows Expr {
    left   Expr
    right  Expr
}
/* Fin definición de subtipos. */

func main() {
    /* Creo una entrada inicializa con las constantes 1 y 20. */
    entrada := Multiple(Const(1), Const(20))
    fmt.Printf("%s\n", entrada)

    /* Trata de matchear con distintos casos. */
    match entrada {
        /* Caso en el cual coincide tipo y valor. */
        case Multiple(Constante(10), Constante(20)):
			fmt.Printf("Matchea tipo y valor (10,20)")

        /* Caso donde se realiza la asignación
           Constante(1) => Constante(x) -> x := 1
           Constante(20) => y := Const(20) */
        case Multiple(Constante(x),y):
			fmt.Printf("Machea x=%v, y=%v\n", x, y)
    }
}
