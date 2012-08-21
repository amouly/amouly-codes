local P in
P = proc { $ X }
       local T in
      T = X>0
      if T then {P X-1} end
       end
    end
end