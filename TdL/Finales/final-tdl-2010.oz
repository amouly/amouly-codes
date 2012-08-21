local X Y Z in
   X = Y
   try
      X = 1
      Y = 2
      Z = 3
   catch Exception then
      skip
   end
   {Browse X#Y#Z}
end