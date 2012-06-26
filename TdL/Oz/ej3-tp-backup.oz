declare CAnd COr CNand CNor CXor

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

CAnd ={ ConstruirCompuerta fun {$ X Y} X*Y end }
COr ={ ConstruirCompuerta fun {$ X Y} X+Y-X*Y end }
CNand={ ConstruirCompuerta fun {$ X Y} 1-X*Y end }
CNor ={ ConstruirCompuerta fun {$ X Y} 1-X-Y+X*Y end }
CXor ={ ConstruirCompuerta fun {$ X Y} X+Y-2*X*Y end }

proc {SumadorCompleto X Y Z ?C ?S}
   K L M
in
   K={CAnd X Y}
   L={CAnd Y Z}
   M={CAnd X Z}
   C={COr K {COr L M}}
   S={CXor Z {CXor X Y}}
end

declare
A0=1|_ B0=0|_ C0 Z0=0|_ S0
A1=1|_ B1=0|_ C1 Z1 S1
A2=1|_ B2=1|_ C2 Z2 S2
A3=0|_ B3=1|_ C3 Z3 S3
A4=0|_ B4=0|_ C4 Z4 S4
A5=0|_ B5=0|_ C5 Z5 S5
A6=0|_ B6=1|_ C6 Z6 S6
A7=1|_ B7=0|_ C7 Z7 S7
in

{SumadorCompleto A0 B0 Z0 C0 S0}
{SumadorCompleto A1 B1 C0 C1 S1}
{SumadorCompleto A2 B2 C1 C2 S2}
{SumadorCompleto A3 B3 C2 C3 S3}
{SumadorCompleto A4 B4 C3 C4 S4}
{SumadorCompleto A5 B5 C4 C5 S5}
{SumadorCompleto A6 B6 C5 C6 S6}
{SumadorCompleto A7 B7 C6 C7 S7}

{Browse S7}
{Browse S6}
{Browse S5}
{Browse S4}
{Browse S3}
{Browse S2}
{Browse S1}
{Browse S0}
