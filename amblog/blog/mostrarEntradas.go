package blog

import (
	"appengine"
    "net/http"
    "html/template"
)

/* Estructura del Blog. */
type Contenido struct {
	Entradas []Entrada
	Categorias []Categoria
}

/* Parseo el template. */
var entradasTpl = template.Must(template.ParseFiles("static/templates/entradas.html"))

func init() {
	/* Asigno el request '/' a la función. */
	http.HandleFunc("/", mostrarEntradas)
}

func mostrarEntradas(w http.ResponseWriter, r *http.Request) {
		
	/* Inicializo el contexto. */
	c := appengine.NewContext(r)	

	entradas := getEntradas(c, 20)
	categorias := getCategorias(c, 10)
    
    contenido := Contenido{entradas, categorias}
    
    /* Ejecuto el template y envio la salida al Writer. */
	err := entradasTpl.Execute(w, contenido)
    
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
    }
}
