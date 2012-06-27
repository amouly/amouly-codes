package blog

import (
	"appengine"
    "appengine/datastore"
)

/* Creo la estructura de las Categorías. */
type Categoria struct {
	Nombre string
	Id int
}

func getCategorias(c appengine.Context, cant int) []Categoria {
	
	/* Creo un slice de 'cant' posiciones. */
	categorias := make([]Categoria, 0, cant)
	
	/* Consulto las categorías a la Datastore. */
	qCat := datastore.NewQuery("Categorias").Order("Nombre")
	
    /* Obengo todas las Categorías de la Datastore. */
	qCat.GetAll(c, &categorias)
	
	return categorias	
}

func agregarCategoria(c appengine.Context, cat *Categoria) error {

    /* Envio los datos de la Categoria a la Datastore. */
    _, err := datastore.Put(c, datastore.NewIncompleteKey(c, "Categorias", nil), cat)
    
    return err
}
