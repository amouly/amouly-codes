import sys
import urllib2
import cssutils
from BeautifulSoup import BeautifulSoup

def obtenerHTML(dirCanal):
	
	fileCanal = urllib2.urlopen(dirCanal)
	contHTML = fileCanal.read()
	fileCanal.close()
	
	return contHTML

def main(argv=sys.argv):
	
	dirCanal = 'http://www.buscadorcablevision.com.ar/dinamicas/grilla_semanal/index.php?canal='+str(argv[1])+'&sintonia='+str(argv[2])+''

	#Inicializo la Sopa
	soup = BeautifulSoup(obtenerHTML(dirCanal))

	#Busco el Nombre del canal y horario
	titulo = soup.find('h4')
	
	print '--------------------------------'
	print '\033[93m'+titulo.text+'\033[0m'

	#Busco todos los Horarios
	listaHoras = soup.findAll('div', attrs={'class': 'hora'})

	#Busco todos los Nombres de los Dias
	contNombresDias = soup.find('div', attrs={'class': 'nav_horas'})

	lunes = contNombresDias.contents[1]
	martes = contNombresDias.contents[3]
	miercoles = contNombresDias.contents[5]
	jueves = contNombresDias.contents[7]
	viernes = contNombresDias.contents[9]
	sabado = contNombresDias.contents[11]
	domingo = contNombresDias.contents[13]

	diasSemana = [[lunes.text, 5], [martes.text, 9], [miercoles.text, 13], [jueves.text, 17], [viernes.text, 21], [sabado.text, 25], [domingo.text, 29]]

	#Busco todos los Dias
	contDias = soup.find('div', attrs={'class': 'cont'})

	for unDia in diasSemana:

		#Selecciono el Dia en el lugar especifico
		elDia = contDias.contents[unDia[1]]
		
		#Busco todos los programas de un Dia
		programas = elDia.findAll('a', attrs={'class': 'programaSemana'})

		contador = 0

		print '---------------------------------------------------'
		print 'Programas para el dia: '+unDia[0]
		print '---------------------------------------------------'

		for programa in programas:
			
			contador = contador+1
			
			#Estilos CSS del Programa
			estilo = cssutils.parseStyle(programa['style'])
			
			print str(contador)+' : '+programa.text+' (height:'+str(estilo.height)+' - top:'+str(estilo.top)+')'
			
if __name__ == "__main__":
	
    main()
