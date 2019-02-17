#################
# Strings
#################

# strings are used to represent text
# by default it's unicode text in python 3 and ascii in python 2

# different ways of representing Strings
# """ quotes often used as for functions or class documents
# ''' used as docstrings

name = 'リムマウウイン'
language = "日本語"
place = """日本"""

"hello".capitalize()
"hello".replace("e", "a")  # First character denotes character to replace
"hello".isalpha()  # == True //
"123".isdigit()  # == True //  Useful when converting to int

# splitting a series of characters into a list
'some,csv,values'.split(',')  # == ['some', 'csv', 'values']

# Printing quotations using backslash
print("\"神様になった日\"")

# Printing normal backslash
print("Σ/神様になった日")

# String concatenation
phrase = "\"神様になった日\""
print(phrase + "かっこいい")

phrase = "Reol"
# Makes a string entirely upper case
print(phrase.upper())

# Makes a string entirely lower case
print(phrase.lower())

# Capitalizes the first word
print(phrase.capitalize())

# Returns a boole if a string is entirely in the upper case or not
print(phrase.isupper())

# Returns a boole if a string is entirely in the lower case or not
print(phrase.islower())

# Makes a string entirely lower case then returns a boole whether a string is entirely in the upper case or not
print(phrase.upper().isupper())

# Printing the length of a string/how many characters
phrase = "\"神様になった日\""
print(len(phrase))

# Prints out the value/character based on the assigned index
phrase = "\"神様になった日\""
print(phrase[1])

# Returns the index value of the given supplied character
phrase = "\"神様になった日\""
print(phrase.index("日\""))

# Replaces an existing value with a different one. Takes two arguments, first bring the target & second being the target value
phrase = "\"神様になった日\""
print(phrase.replace("日", "月"))


