package main

func MezclaOrdenada(Pos int, listaUno, listaDos []int, listaFinal *[]int) {
	if listUno[pos]=< listaDos[pos] {
		copy(listaFinal, listaUno[pos])
		//copy(listaFinal[pos:], MezclaOrdenada())
	} 
}

listaUno := [1 3 5 7 9 11]
listaDos := [2 4 6 8 10]

listaFinal := make([]int, len(listaUno)+len(listaDos))

MezclaOrdenada(1, listaUno, listaDos, &listaFinal)
