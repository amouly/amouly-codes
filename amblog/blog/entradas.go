package blog

import (
	"appengine"
    "appengine/datastore"
    "time"
)

/* Creo la estructura de las Entradas. */
type Entrada struct {
	Titulo string
	Contenido string
	Autor string
	Categoria string
	Fecha time.Time
}

func getEntradas(c appengine.Context, cant int) []Entrada {
	
	/* Creo un slice de 'cant' posiciones. */
	entradas := make([]Entrada, 0, cant)
	
	/* Consulto las entradas a la Datastore. */
	q := datastore.NewQuery("Entradas").Order("-Fecha").Limit(cant)
	
	/* Obengo todas las Entradas de la Datastore. */
	q.GetAll(c, &entradas)
	
	return entradas
}

func agregarEntrada(c appengine.Context, ent *Entrada) error {
    
    /* Envio los datos de la Entrada a la Datastore. */
    _, err := datastore.Put(c, datastore.NewIncompleteKey(c, "Entradas", nil), ent)
      
    return err
}
