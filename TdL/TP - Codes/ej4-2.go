package main

import (
	"fmt"
	"sort"
)

/* Creo una estrcutura de mapa ordenado */
type mapaOrdenado struct {
	m map[string]int
	s []string
}

func (sm *mapaOrdenado) Len() int {
	return len(sm.m)
}

func (sm *mapaOrdenado) Less(i, j int) bool {
	return sm.m[sm.s[i]] > sm.m[sm.s[j]]
}

func (sm *mapaOrdenado) Swap(i, j int) {
	sm.s[i], sm.s[j] = sm.s[j], sm.s[i]
}

func ordenarClaves(m map[string]int) []string {
	sm := new(mapaOrdenado)
	sm.m = m
	sm.s = make([]string, len(m))
	i := 0
	for key, _ := range m {
		sm.s[i] = key
		i++
	}
	
	sort.Sort(sm)
	return sm.s
}

/* Estrcutra de Diccionario */
type Diccionario map[string]int

/* Creo un Diccionario vacío y lo devuelvo. */
func NuevoDicc() (nuevoDicc Diccionario) {
	nuevoDicc = make(map[string]int)
	
	fmt.Println("Se creo el dicc")
	
	return nuevoDicc
}

/* {Put Dicc Clave Valor}: inserta el par Clave:Valor en el diccionario */
func (unDicc *Diccionario) Put(clave string, valor int) {
	
	(*unDicc)[clave] = valor
}

/* {Get Dicc Clave}: devuelve el Valor asociado a la Clave */
func (unDicc *Diccionario) Get(clave string) (valor int, existe bool) {
	if (*unDicc)[clave] != 0 {
		return (*unDicc)[clave], true
	}
	
	return 0, false
}

/* {Domain Dicc}: devuelve una lista con todas las claves presentes en el diccionario Dicc */
func (unDicc *Diccionario) Domain() (unaLista []string) {

	unaLista = ordenarClaves((*unDicc))
	
	return unaLista
}

func main(){
	
	/* Creo una Cadena y un Diccionario */
	unaCadena := "elquesabesabeyelquenoesjefe"
	unDiccionario := NuevoDicc()
	
	/* Cargo el Diccionario con los caracteres de la Cadena */
	for _,vC :=range(unaCadena){

		vD, ok := unDiccionario.Get(string(vC))

		if ok {
			/* El valor vC existe y se aumenta a vC+1 */
			unDiccionario.Put(string(vC), vD+1)
		} else {
			/* El valor vC NO existe y se aumenta a 1 */
			unDiccionario.Put(string(vC), 1)
		}
	}
	
	dominio := unDiccionario.Domain()
	
	/* Recorre e imprime el diccionario ordenado */
	for _,v :=range(dominio){
		cant, _ := unDiccionario.Get(v)
		fmt.Println(v, ":", cant)
	}
}
