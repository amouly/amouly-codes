declare MezclaOrdenada L1 L2 in

fun {MezclaOrd Xs Ys}
   case Xs#Ys
   of nil#Ys then Ys
   [] Xs#nil then Xs
   [] (X|Xr)#(Y|Yr) then
      if X=<Y then X|{MezclaOrd Xr Ys}
      else Y|{MezclaOrd Xs Yr} end
   end
end

L1 = 1|3|5|7|9|11|nil
L2 = 2|4|6|8|10|nil

{Browse {MezclaOrdenada L1 L2}}
