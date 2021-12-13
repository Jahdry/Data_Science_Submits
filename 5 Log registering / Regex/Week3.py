""" REGULAR EXPRESIONS --> REGEX / REGESP"""
""" Is a search query for text that's expressed by string pattern"""

" grep = comando bash para buscar si un string aparece en un fichero de texto." \
"Muestra en pantalla todas las lineas donde aparece el substrin" \
"grep = key sensitive. grep -i = no key sensitive" \
" . indica que puede ser cualquier caracter l.na = luna, lina, lona, etc..." \
" ^ = principio de linea, rep ^fruit = todas las lineas que comienzan por fruit"\
" $ = final de linea; grep cat$ = todas las lineas que acaban con cat "


import re

result = re.search(r"aza", "bazaar") #la "r" significa que el strig a buscar es un Rawstring (No tiene caracteres especiales)
print(result) #Devuelve el rango de los caracteres y el substring que hace match. Si no hay coincidencia devuelve None
print(re.search(r"p.ng", "penguin"))
print(re.search(r"^X", "Xenon"))
print(re.search(r"p.ng", "Pangea", re.IGNORECASE))# Con este parametro hacemos que no sea key sensitive

"Character classes = se escriben entre [] para ver si se cumplen ciertas carácteísticas"
print(re.search(r"[Pp]ython", "Python seach engine")) #busca tanto con "P" como con "p"
print(re.search(r"[a-z]way", "Highway")) #busca en el rango de caracteres "a-z"
print(re.search(r"[Cc]loud[a-zA-Z0-9]", "cloudy"))
print(re.search(r"[Cc]loud[a-zA-Z0-9]", "Cloud9"))#podemos definir todos los rangos que queramos dentro de las claves
print(re.search(r"[^a-zA-Z]", "This is a sentence with a spaces.")) #el "^" dentro de [] busca lo que está fuera de rango defindo
print(re.search(r"Cat|Dog", "I like Cats."))
print(re.search(r"Cat|Dog", "I like Dogs."))# El simbolo "|" se utiliza como sinonimo de "or"
print(re.findall(r"Cat|Dog", "I like Cats and Dogs."))# Findall Devuelve todos los resultados"

print(re.search(r"Py.*n", "Pygmallion")) #El * cualquier numero de caracteres detras del
print(re.search(r"Py.*n", "Python programming"))
print(re.search(r"Py[a-z]*n", "Python programming"))
print(re.search(r"o+l+", "Woolly")) # "+" busca una o más ocurrencias del caracter precedente
print(re.search(r"p?each", "I like each")) # "?" busca 0 o 1 una ocurrencias del caracter precedente

print(re.search(r"\.com", "viacom concrete.com")) # El Escape caracter "\" sirve para inutilizar a los otros special caracters.
print(re.search(r"\w*","This is an example")) # \w = cualquier caracter alfanumerico incluidos "_"
"\d = digits; \s = Whitespaces (Space, tab, newline); \b = word boundaries"


"Captouring Groups = porciones del string que están englobadas entre parentesis. con estos grupos podemos hacer otras operaciones posteriormente."

result = re.search(r"^(\w*), (\w*)$", "Lovelace, Ada")
print(result)
print(result.groups()) # Devuelve un tuple con cada grupo
print(result[0]) # El Index 0 es toda el string
print(result[1]) # El Idnex 1 es el primer grupo
print(result[2]) # El Index 2 es el segundo grupo
print ("{} {}".format(result[2], result[1]))

def rearrange_name(name):
    result = re.search(r"^([\w .-]*), ([\w .-]*)$", name)
    if result == None:
        return name
    return ("{} {}".format(result[2], result[1]))

print(rearrange_name("Hopper, Grace M."))
print(rearrange_name("Giraud, Jean-Paul"))
print(rearrange_name("Degrase, Johawn"))
print(rearrange_name("Tupple, Fuckin"))

"Numeric repetition qualifiers {}"
print(re.search(r"[a-zA-z]{5}", "a ghost"))
print(re.findall(r"[a-zA-z]{5}", "a scary ghost appeared"))
print(re.findall(r"\b[a-zA-z]{5}\b", "a scary ghost appeared")) # \b = word boundaries
print(re.findall(r"[a-zA-z]{5,10}", "I really like strawberries")) # se pueden usar intervalos de caracteres
print(re.findall(r"\b\w{3,}\b", "a scary ghost appeared"))
print(re.findall(r"s\w{,20}", "I really like strawberries"))

def extract_pid(log_line):
    regex = r"\[(\d+)\]: \b([A-Z]*)\b"
    result = re.search(regex, log_line)
    if result is None:
        return "Not match found"
    return "{}, {}".format(result[1], result[2])

print(extract_pid("July 31 07:51:48 mycomputer bad_process[12345]: ERROR Performing package upgrade"))
print(extract_pid("99 elephants in a [cage]"))

""" SPLITTNG AND REPLACING"""
print(re.split(r"[?!.]", "One sentence. Another one? And the last one!")) #Separa el sting y devuelve una lista con los substrin separados
print(re.split(r"([?!.])", "One sentence. Another one? And the last one!")) #si queremos que se incluyan los caracteres separadoresse inclyan en la lista los tenemos que poner entre ()

print(re.sub(r"[\w%+-]+@[\w.-]+", "[REDTAPED]", "Received an email for go_nuts95@breaker.balls"))# substituye regular expresion por strings
print(re.sub(r"^([\w .-]*), ([\w .-]*)$", r"\2 \1", "Lovelace, Ada")) # Podemos substituir grupos y devolverlos en diferente orden.
# En esta función "\2" hace referencia al index del grupo

