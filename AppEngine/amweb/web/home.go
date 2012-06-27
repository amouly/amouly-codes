package blog

import (

    "net/http"
    "html/template"
)


/* Parseo el template. */
var homeTpl = template.Must(template.ParseFiles("static/templates/home.html"))

func init() {
	/* Asigno el reques a la función. */
    http.HandleFunc("/", mostrarHome)
}

func mostrarHome(w http.ResponseWriter, r *http.Request) {	

	var tc map[string]string
	tc = make(map[string]string)
	
	tc["TituloWeb"]="Familia Mouly"
    
    /* Ejecuto el template y envio la salida al Writer. */
	err2 := homeTpl.Execute(w, tc)
    
    if err2 != nil {
        http.Error(w, err2.Error(), http.StatusInternalServerError)
    }
}
