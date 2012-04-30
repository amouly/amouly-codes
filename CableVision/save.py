for dia in dias:

	print '---------- INICIO DIA ------------- '

	programas = dia.findAll('a', attrs={'class': 'programaSemana'})
	
	contador = 0
	
	for programa in programas:
		
		contador = contador+1
		print programa.text
		print contador
		
	print '---------- FIN DIA ------------- '

for hora in horas:

	print hora.text
