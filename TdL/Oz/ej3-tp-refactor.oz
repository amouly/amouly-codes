declare R1 R2 R3 R4 R5

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

proc {SumadorCompleto X Y Z ?C ?S}
   K L M CAnd COr CNand CNor CXor
in
   CAnd = {ConstruirCompuerta fun {$ X Y} X*Y end}
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


fun {SumadorOchoBit X1 X2 X3 X4 X5 X6 X7 X8 Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8}

   A0=X8|_ B0=Y8|_ C0 Z0=0|_ S0
   A1=X7|_ B1=Y7|_ C1 Z1     S1
   A2=X6|_ B2=Y6|_ C2 Z2     S2
   A3=X5|_ B3=Y5|_ C3 Z3     S3
   A4=X4|_ B4=Y4|_ C4 Z4     S4
   A5=X3|_ B5=Y3|_ C5 Z5     S5
   A6=X2|_ B6=Y2|_ C6 Z6     S6
   A7=X1|_ B7=Y1|_ C7 Z7     S7

in
   {SumadorCompleto A0 B0 Z0 C0 S0}
   {SumadorCompleto A1 B1 C0 C1 S1}
   {SumadorCompleto A2 B2 C1 C2 S2}
   {SumadorCompleto A3 B3 C2 C3 S3}
   {SumadorCompleto A4 B4 C3 C4 S4}
   {SumadorCompleto A5 B5 C4 C5 S5}
   {SumadorCompleto A6 B6 C5 C6 S6}
   {SumadorCompleto A7 B7 C6 C7 S7}
   
   C7|S7|S6|S5|S4|S3|S2|S1|S0
end

R1={SumadorOchoBit 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1}
R2={SumadorOchoBit 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 1}
R3={SumadorOchoBit 0 0 0 0 0 0 1 1 0 0 0 0 0 1 0 1}
R4={SumadorOchoBit 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1}
R5={SumadorOchoBit 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 1}

{Browse R1}
{Browse R2}
{Browse R3}
{Browse R4}
{Browse R5}
