import urllib2, libxml2

urlPrima = 'http://24.232.0.118/asp/nivelesPrima.asp'
camposImportantes = ['Tx', 'Rx', 'MER']

f = urllib2.urlopen(urlPrima)
html = f.read()
f.close()

parse_options = libxml2.HTML_PARSE_RECOVER + \
	libxml2.HTML_PARSE_NOERROR + \
	libxml2.HTML_PARSE_NOWARNING

doc = libxml2.htmlReadDoc(html, '', None, parse_options)

campos = doc.xpathEval('//td')

print '----------------'
print 'Niveles FiberTel'
print '----------------'

for campo in campos:
		
	if campo.content in camposImportantes:
		
		valor = campo.next.next
		
		print '\033[93m'+campo.content+': '+valor.content+'\033[0m'
		print '--------------'
	
doc.freeDoc()
