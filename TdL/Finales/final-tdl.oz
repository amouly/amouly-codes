local Correct in
   fun {Correct S}
      case S
      of nil then nil
      [] & |& |S1 then {Correct & |S1}
      [] C|S1 then C|{Correct S1} end
   end

   {Browse {Correct "This  is  a test"}}
end