package blog

import (
	"appengine"
    "appengine/datastore"
    "net/http"
    "html/template"
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

/* Parseo el template. */
var entradasTpl = template.Must(template.ParseFiles("static/templates/entradas.html"))

func init() {
	/* Asigno el reques a la función. */
    http.HandleFunc("/", mostrarEntradas)
}

func mostrarEntradas(w http.ResponseWriter, r *http.Request) {
		
	/* Inicializo el contexto. */
	c := appengine.NewContext(r)
	
	/* Consulto las entradas a la Datastore. */
	q := datastore.NewQuery("Entradas").Order("-Fecha").Limit(10)
	
	/* Creo un slice de 10 posiciones. */
	entradas := make([]Entrada, 0, 10)
	
	/* Obengo todas las Entradas de la Datastore. */
	_, err := q.GetAll(c, &entradas)
	
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    
    /* Ejecuto el template y envio la salida al Writer. */
	err2 := entradasTpl.Execute(w, entradas)
    
    if err2 != nil {
        http.Error(w, err2.Error(), http.StatusInternalServerError)
    }
}
