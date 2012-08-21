% La segunda aparición de P con respecto al procedimiento se encuentra libre, ya que la ligadura de este identificador se realiza fuera del mismo.
local P in
   P = proc{$ X}
	  local T in
	     T=X>0
	     if T then {P X-1} end
	  end
       end
end