package blog

import (
    "appengine"
    "appengine/user"
    "net/http"
    "html/template"
    "time"
    "fmt"
)

type ContenidoAdmin struct {
	Categorias []Categoria
}

/* Parseo el template. */
var adminTpl = template.Must(template.ParseFiles("static/templates/admin.html"))

func init() {
	/* Asigno los reques a cada función. */
    http.HandleFunc("/admin/", admin)
    http.HandleFunc("/agregar-entrada/", agregarEntradaHandler)
    http.HandleFunc("/agregar-categoria/", agregarCategoriaHandler)
}

func admin(w http.ResponseWriter, r *http.Request) {
    c := appengine.NewContext(r)
    u := user.Current(c)
    
    if u == nil {
        url, err := user.LoginURL(c, r.URL.String())
        
        if err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
            return
        }
        
        w.Header().Set("Location", url)
        w.WriteHeader(http.StatusFound)
        return
    }
    
    /* Si el usuario es administrador. */
    if user.IsAdmin(c) {

		categorias := getCategorias(c, 10)
		
		contenido := ContenidoAdmin{categorias}
		
		/* Ejecuto el template y envio la salida al Writer. */
		err2 := adminTpl.Execute(w, contenido)
		
		if err2 != nil {
			http.Error(w, err2.Error(), http.StatusInternalServerError)
		}
	} else {
		fmt.Fprint(w, "El usuario no es admin.")
	}
}

func agregarEntradaHandler(w http.ResponseWriter, r *http.Request){
	/* Inicializo el usuario y contexto actuales. */
	c := appengine.NewContext(r)
	u := user.Current(c)
	
	/* Creo una Entrada con los datos del formulario. */
	unaEntrada := Entrada {
		Titulo: r.FormValue("titulo"),
		Contenido: r.FormValue("contenido"),
		Categoria: r.FormValue("categoria"),
		Fecha: time.Now(),
    }
    
    if u != nil {
        unaEntrada.Autor = u.String()
    }
    
	err := agregarEntrada(c, &unaEntrada)
    
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    
    /* Redirijo a la sección de Admin. */
    http.Redirect(w, r, "/admin/", http.StatusFound)
}

func agregarCategoriaHandler(w http.ResponseWriter, r *http.Request){
	/* Inicializo el usuario y contexto actuales. */
	c := appengine.NewContext(r)
	
	/* Creo una Entrada con los datos del formulario. */
	unaCategoria := Categoria {
		Nombre: r.FormValue("nombre"),
    }
    
	err := agregarCategoria(c, &unaCategoria)
    
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    
    /* Redirijo a la sección de Admin. */
    http.Redirect(w, r, "/admin/", http.StatusFound)
}
