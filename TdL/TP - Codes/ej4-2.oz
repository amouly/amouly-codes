% Función NuevoDicc -> Crea un nuevo Diccionario y define las funciones del mismo.
declare fun {NuevoDicc}

   local Diccionario EstaVacio DiccionarioBorrar DiccionarioDominio DiccionarioMostrar DiccionarioGet DiccionarioPut DiccionarioOrdenarFrec Empty Domain Get Put Show Remove CargarDatos OrdenarFrecuencia in

      % Diccionario con Estados.
      Diccionario={NewCell nil}

      % Funciones que implementan el funcionamiento de un Diccionario.
      
      % Función EstaVacio -> Devuelve verdadero o falso según el contenido del Diccionario.
      fun {EstaVacio UnDicc}	
	 UnDicc==nil
      end		

      % Función DiccionarioBorrar -> Recibe un Diccionario Inicial y devuelve un Diccionario alterado.
      fun {DiccionarioBorrar DiccInicial Clave}						
	 case DiccInicial
	 of H|T then
	    if H.clave==Clave then
	       T
	    else
	       H|{DiccionarioBorrar T Clave}
	    end
	 else nil
	 end
      end

      % Función DiccionarioGet -> Recibe un Diccionaro y la Clave a obtener. Devuelve el valor asociado a Clave.
      fun {DiccionarioGet UnDicc Clave}
	 case UnDicc
	 of H|T then
	    if H.clave==Clave then H.valor
	    else
	       {DiccionarioGet T Clave}
	    end
	 else 0
	 end
      end

      % Función DiccionarioPut -> Recibe un Diccionario y la Clave/Valor a agregar.
      fun {DiccionarioPut DiccInicial ClaveA ValorA}
	 local DiccAux Elem ElemAux in
	    % Si el Diccicionario Inicial esta vacio, se agrega el elemento.
	    if {EstaVacio DiccInicial} then 			
	       ElemAux=counter(clave:ClaveA valor:ValorA)
	       ElemAux|DiccInicial
	    else
	       DiccAux=DiccInicial.2
	       Elem=DiccInicial.1
	       
	       % Si la cavle ya existe, se suman los valores y se retorna una nueva lista.
	       if Elem.clave==ClaveA then
		  ElemAux=counter(clave:ClaveA valor:Elem.valor+ValorA)
		  ElemAux|DiccAux
	       else
		  % Si es otro caso, analiza el siguiente elemento.
		  Elem|{DiccionarioPut DiccAux ClaveA ValorA}
	       end
	    end
	 end
      end

      % Función DiccionarioDominio -> Devuelve una lista con las claves del Diccionario. 
      fun {DiccionarioDominio UnDicc}	
	 if {EstaVacio UnDicc} then nil
	 else
	    local Elem in
	       Elem.clave|{DiccionarioDominio {DiccionarioGet UnDicc Elem.clave}}
	    end
	 end
      end

      % Función DiccionarioOrdenarFrec -> Recibe un Diccionario y lo ordena según la Frecuencia.
      fun {DiccionarioOrdenarFrec UnDicc}
	 local AgregarOrdenado in
	    % Función AgregarOrdenado - Recibe una lista y devuelve otra Lista con el elemento agregado segun el orden.
	    fun {AgregarOrdenado ListaInicial Elem}
	       case ListaInicial of
		  nil then Elem|nil
	       [] H|T then
		  if H.valor>Elem.valor then
		     H|{AgregarOrdenado T Elem}
		  else
		     if H.valor<Elem.valor then  
			Elem|H|T
		     else
			if H.clave>Elem.clave then
			   Elem|H|T
			else
			   H|{AgregarOrdenado T Elem}
			end
		     end
		  end
	       end
	    end

	    if {EstaVacio UnDicc} then nil
	    else
	       local DiccAux ListaAux Elem in
		  DiccAux=UnDicc.2
		  Elem=UnDicc.1
		  ListaAux={DiccionarioOrdenarFrec DiccAux}
		  {AgregarOrdenado ListaAux Elem}
	       end
	    end
	 end
      end

      % Funcion DiccionarioMostrar -> Muestra el contenido del Diccionario.
      proc {DiccionarioMostrar UnaLista}
	 case UnaLista of H|T then
	    {Browse [H.clave ':' H.valor]}  
	    case T of X|Y then
	       {DiccionarioMostrar T}
	    else
	       skip
	    end
	 end
      end

      % Funciones que encapsulan el funcionamiento del Diccionario.

      % Función Empty - Diccionario -> Determina si el Diccionario esta o no vacío.
      fun {Empty}
	 {EstaVacio @Diccionario}
      end
            
      % Función Dominio - Diccionario -> Devuelve una lista con todas las claves presentes en el diccionario.
      fun {Domain} 
	 {DiccionarioDominio @Diccionario}
      end

      % Función Get - Diccionario -> Devuelve el Valor asociado a la Clave.
      fun {Get Clave}		
	 {DiccionarioGet @Diccionario Clave}
      end
      
      % Función Put - Diccionario -> Inserta valores al Diccionario.
      proc {Put Clave Valor}
	 Diccionario:={DiccionarioPut @Diccionario Clave Valor}
      end

      % Función Remove - Diccionario -> Borra valores asociados a la Clave.
      fun {Remove Clave}
	 Diccionario:={DiccionarioBorrar @Diccionario Clave}
      end

      % Función Mostrar - Diccionario -> Muestra el contenido del Diccionario.
      proc {Show}	
	 {DiccionarioMostrar @Diccionario}	
      end

      % Función OrdenarFrecuencia - Diccionario -> Ordena el diccionario segúna la frecuencia.
      proc {OrdenarFrecuencia}
	 Diccionario:={DiccionarioOrdenarFrec @Diccionario}
      end

      % Procedimiento CargarDatos - Diccionario -> Recibe una lista y carga la información al Diccionario.
      proc {CargarDatos UnaLista}		
	 case UnaLista
	 of H|T then
	    % Carga la cabeza.
	    {Put H 1}
	    % Carga la cola recursivamente.
	    {CargarDatos T}
	 [] nil then skip
	 end		
      end

      % Asignación de métodos al Diccionario.
      elDiccionario(diccionario: Diccionario
		    empty: Empty
		    get: Get
		    put: Put
		    remove: Remove
		    domain: Domain
		    ordenarFrecuencia: OrdenarFrecuencia
		    cargarDatos: CargarDatos
		    mostrar: Show)
   end
end

local ElDiccionario ListaLetras in
   % Se crea la frase inicial.
   ListaLetras=[e l q u e s a b e s a b e y e l q u e n o e s j e f e]

   % Se crea un diccionario.
   ElDiccionario={NuevoDicc}

   % Se cargan los datos al Diccionario en base a la lista de letras.
   {ElDiccionario.cargarDatos ListaLetras}

   % Ordena el contenido del Diccionario por Frecuencia.
   {ElDiccionario.ordenarFrecuencia}

   % Muestra el contenido del Diccionario.
   {ElDiccionario.mostrar}
end
