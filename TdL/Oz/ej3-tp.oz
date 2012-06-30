declare CAnd COr CNand CNor CXor

proc {SumadorCompleto X Y Z ?C ?S}
	K L M
   
	fun {ConstruirCompuerta F}
		fun {$ Xs Ys}
			fun {CicloCompuerta Xs Ys}
				case Xs#Ys of (X|Xr)#(Y|Yr) then
				{F X Y}|{CicloCompuerta Xr Yr}
			end
		end
	in
		thread {CicloCompuerta Xs Ys} end
	end
end 
in
	CAnd = {ConstruirCompuerta fun {$ X Y} X*Y end }
	COr = {ConstruirCompuerta fun {$ X Y} X+Y-X*Y end}
	CNand= {ConstruirCompuerta fun {$ X Y} 1-X*Y end}
	CNor = {ConstruirCompuerta fun {$ X Y} 1-X-Y+X*Y end}
	CXor = {ConstruirCompuerta fun {$ X Y} X+Y-2*X*Y end}  

	K={CAnd X Y}
	L={CAnd Y Z}
	M={CAnd X Z}
	C={COr K {COr L M}}
	S={CXor Z {CXor X Y}}
end

proc {Sumador8Bits
				A0 A1 A2 A3 A4 A5 A6 A7
				B0 B1 B2 B3 B4 B5 B6 B7
				?S0 ?S1 ?S2 ?S3 ?S4 ?S5 ?S6 ?S7}
	C0 Z0=0|_ S0
	C1 Z1 S1
	C2 Z2 S2
	C3 Z3 S3
	C4 Z4 S4
	C5 Z5 S5
	C6 Z6 S6
	C7 Z7 S7
in
	{SumadorCompleto A0 B0 Z0 C0 S0}
	{SumadorCompleto A1 B1 C0 C1 S1}
	{SumadorCompleto A2 B2 C1 C2 S2}
	{SumadorCompleto A3 B3 C2 C3 S3}
	{SumadorCompleto A4 B4 C3 C4 S4}
	{SumadorCompleto A5 B5 C4 C5 S5}
	{SumadorCompleto A6 B6 C5 C6 S6}
	{SumadorCompleto A7 B7 C6 C7 S7}
end

declare
	A0=1|0|1_ B0=0|1|0_
	A1=1|1|0_ B1=0|1|0_
	A2=1|1|1_ B2=1|1|0_
	A3=0|1|0_ B3=1|1|0_
	A4=0|0|1_ B4=0|1|1_
	A5=0|0|0_ B5=0|1|1_
	A6=0|1|1_ B6=1|0|1_
	A7=1|1|0_ B7=0|0|1_
	
	CARRY1 SUMA1
in
	{Sumador8Bits A0 A1 A2 A3 A4 A5 A6 A7 B1 B2 B3 B4 B5 B6 B7 CARRY1 SUMA1}
	
	{Browse SUMA1}
