local NuevoWrapper NuevoStack NuevoDicc Put Get Dominio CargarFrec AgregarOrdenado Push Pop EstaVacio Frecuencias Wrap Unwrap MostrarFrecuencias ListaInicial ListaFrecuencias ElDiccionario in

   % --- Funciones Auxiliares de Wrapper y Stack ---
   
   % Procedimiento NuevoWrapper -> Crea las funciones Wrap y Unwrap. 
   proc {NuevoWrapper ?Wrap ?Unwrap}
      local Key={NewName} in
	 fun {Wrap X}
	    fun {$ K}
	       if K==Key then X end
	    end
	 end
	 
	 fun {Unwrap W} {W Key} end	 
      end
   end
   
   % Función NuevoStack -> Devuelve un Wrapper vacío
   fun {NuevoStack} {Wrap nil} end

   % Función Push -> Recibe un Stack y un Elemento. El Elemento es agregado al Stack.
   fun {Push UnStack Elem} {Wrap Elem|{Unwrap UnStack}} end

   % Función Pop -> Recibe un Stack. Devuelve un Elemento del Stack.
   fun {Pop UnStack ?Elem} 
      case {Unwrap UnStack} of X|S1 then 
	 Elem=X
	 {Wrap S1}
      end
   end

   % Función EstaVacio -> Recibe un Stack. Devuelve un booleano en caso positivo o negativo.
   fun {EstaVacio UnStack} {Unwrap UnStack}==nil end

   % --- Funciones del Diccionario ---

   % Función NuevoDicc -> Crea un nuevo diccionario utilizando un Stack.
   fun {NuevoDicc} {NuevoStack} end
 
   % Función Put -> Agrega elementos al diccionario. Recibe un Diccionario y agrega un Valor y Clave.
   fun {Put Dicc Clave Valor}
      local DiccAux Elemento ElementoAux in		
	 if {EstaVacio Dicc} then 		
	    ElementoAux=counter(clave:Clave valor:Valor)
	    {Push Dicc ElementoAux}
	 else
	    DiccAux={Pop Dicc Elemento}
	    if Elemento.clave==Clave then
	       {Put DiccAux Clave Elemento.valor+1}
	    else
	       {Push {Put DiccAux Clave Valor} Elemento}
	    end
	 end
      end	
   end

   % Función Get -> Recibe un Dicconario y la Clave a obtener su valor. Devuelve el valor de la clave.
   fun {Get Dicc Clave}	
      local DiccAux Elemento in		
	 if {EstaVacio Dicc} then nil
	 else
	    % Diccionario Auxilar con un elemento menos.
	    DiccAux={Pop Dicc Elemento}
	    
	    if Elemento.clave==Clave then
	       Elemento.valor
	    else
	       % Analiza recursivamente el Diccionario Auxiliar restante.
	       {Get DiccAux Clave}
	    end
	 end
      end
   end

   % Funcion Dominio -> Recibe un diccionario por parámetros. Devuelve la lista de claves que existen en el Dicc.
   fun {Dominio UnDicc}
      if {EstaVacio UnDicc} then nil
      else
	 local DiccAux Elemento in
	    DiccAux={Pop UnDicc Elemento}
	    Elemento.clave|{Dominio DiccAux}
	 end
      end
   end
	
   % Funcion CargarFrecuencia -> Recibe una lista de claves y devuelve un diccionario cargado con la frecuencia de cada clave en la lista.
   fun {CargarFrec UnaLista}
      case UnaLista of 
	 nil then {NuevoDicc}
      [] H|T then
	 local DiccAux Clave in
	    Clave=H
	    DiccAux={CargarFrec T}
	    {Put DiccAux Clave 1}
	 end
      end
   end

   % Función AgregarOrdenado -> Agrega un elemento ordenando la lista según frecuencia y clave. Devuelve la lista con el nuevo elemento.
   fun {AgregarOrdenado ListaOrigen Elemento}
      % Analiza la lista segun sea el caso.
      case ListaOrigen of nil then Elemento|nil
      [] H|T then
	 % La frecuencia de H mayor <-> H se analiza primero
	 if H.valor > Elemento.valor then
	    H|{AgregarOrdenado T Elemento}
	 else
	    % La frecuencia de H menor <-> El Elemento es la cabeza
	    if H.valor<Elemento.valor then
	       Elemento|H|T
	    else
	       % A igual Frecuencia y Clave Mayor <-> El Elemento es la cabeza
	       if H.clave>Elemento.clave then
		  Elemento|H|T
	       else
		  % A igual Frecuencia y Clave Menor <-> Sigue primera la Cabeza y se analiza el resto
		  H|{AgregarOrdenado T Elemento}
	       end
	    end
	 end
      end
   end

   % Función Frecuencias -> Recibe un Diccionario y devuelve una nueva Lista de elementos ordenada por Frecuencia y Clave.
   fun {Frecuencias UnDicc}
      if {EstaVacio UnDicc} then nil
      else
	 local DiccAux ListaAux Elemento in
	    DiccAux={Pop UnDicc Elemento}
	    ListaAux={Frecuencias DiccAux}
	    {AgregarOrdenado ListaAux Elemento}
	 end
      end
   end

   % Procedimiento MostrarFrecuencias -> Imprime en pantalla las frecuencias recorriendo una Lista ordenada.
   proc {MostrarFrecuencias UnaLista}
      case UnaLista of H|T then
	 {Browse [H.clave ':' H.valor]}

	 % En caso de que la cola sea una lista, la analiza.
	 case T of X|Y then
	    {MostrarFrecuencias T}
	 else
	    skip
	 end
      end
   end

   % Se crea el Wrapper con sus dos funciones.
   {NuevoWrapper Wrap Unwrap}
   
   % Programa Principal -> Imprime la lista de letras y la frecuencia de las letras.
   
   % Lista de letras que se analizará.
   ListaInicial=[e l q u e s a b e s a b e y e l q u e n o e s j e f e]

   % Carga la frecuencia de las letras al Diccionario.
   ElDiccionario={CargarFrec ListaInicial}

   % Genera una nueva Lista con los datos Ordenados.
   ListaFrecuencias={Frecuencias ElDiccionario}

   % Muestra el resultado final pedido.
   {MostrarFrecuencias ListaFrecuencias}
end
