package admin

import (
    "appengine"
    "appengine/datastore"
    "appengine/user"
    "net/http"
    "html/template"
    "time"
    "fmt"
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
var adminTpl = template.Must(template.ParseFiles("static/templates/admin.html"))

func init() {
	/* Asigno los reques a cada función. */
    http.HandleFunc("/admin/", admin)
    http.HandleFunc("/agregar-entrada/", agregarEntrada)
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
		tc := make(map[string]interface{})
		
		/* Ejecuto el template y envio la salida al Writer. */
		err2 := adminTpl.Execute(w, tc)
		
		if err2 != nil {
			http.Error(w, err2.Error(), http.StatusInternalServerError)
		}
	} else {
		fmt.Fprint(w, "El usuario no es admin.")
	}
}

func agregarEntrada(w http.ResponseWriter, r *http.Request){
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
    
    /* Envio los datos de la Entrada a la Datastore. */
    _, err := datastore.Put(c, datastore.NewIncompleteKey(c, "Entradas", nil), &unaEntrada)
    
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    
    /* Redirijo a la sección de Admin. */
    http.Redirect(w, r, "/admin/", http.StatusFound)
}
