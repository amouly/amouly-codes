fun {CarDePalabra C}
	(&a=<C andthen C=<&z) orelse
	(&A=<C andthen C=<&Z) orelse (&0=<C andthen C=<&9)
end

fun {PalAAtomo PW}
	{StringToAtom {Reverse PW}}
end

fun {IncPal D W}
	{Agregar D W {ConsultarCond D W 0}+1}
end

fun {CarsAPalabras PW Cs}
	case Cs
	of nil andthen PW==nil then
		nil
	[] nil then
		[{PalAAtomo PW}]
	[] C|Cr andthen {CarDePalabra C} then
		{CarsAPalabras {Char.toLower C}|PW Cr}
	[] C|Cr andthen PW==nil then
		{CarsAPalabras nil Cr}
	[] C|Cr then
		{PalAAtomo PW}|{CarsAPalabras nil Cr}
	end
end

fun {ContarPalabras D Ws}
	case Ws
	of W|Wr then {ContarPalabras {IncPal D W} Wr}
	[] nil then D
	nd
end

fun {FrecPalabras Cs}
	{ContarPalabras {DiccionarioNuevo} {CarsAPalabras nil Cs}}
end


local Envolver Desenvolver in
	{NuevoEmpacador Envolver Desenvolver}
	fun {PilaNueva} {Envolver nil} end
	
fun {Colocar S E} {Envolver E|{Desenvolver S}} end

fun {Sacar S E}
	case {Desenvolver S} of X|S1 then E=X {Envolver S1} end
end




local
	{NuevoEmpacador Envolver Desenvolver}
	
	% Definiciones previas:
	fun {DiccionarioNuevo} {Envolver nil} end
	
	fun {Agregar Ds K Valor} ... end
	
	fun {ConsultarCond Ds K Defecto} ... end
	
	fun {Dominio2 Ds} ... end
in
	% Primitivas del diccionario

	fun {NewDicc}
		{Envolver {DiccionarioNuevo}}
	end
	
	fun {Put Dicc Clave Valor}
		{Envolver {Agregar {Desenvolver Dicc} Clave Valor}}
	end
	
	fun {ConsultarCond Ds K Defecto}
		{ConsultarCond2 {Desenvolver Ds} K Defecto}
	end
	
	fun {Domain Dicc}
		{Dominio {Desenvolver Dicc}}
	end

