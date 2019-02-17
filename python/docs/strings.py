#################
#	 Strings	#
#################

#	strings are used to represent text
#	by default it's unicode text in python 3 and ascii in python 2

#	different ways of representing Strings
#	""" quotes often used as for functions or class documents
# 	''' used as docstrings

name = 'リムマウウイン'
language = "にほん語"
place = """日本"""

"hello".capitalize()
"hello".replace("e", "a")  # First character denotes character to replace
"hello".isalpha()  # == True //
"123".isdigit()  # == True //  Useful when converting to int

#	splitting a series of characters into a list
'some,csv,values'.split(',')  # == ['some', 'csv', 'values']

#	String format function
#   This is useful for when the variable keys will change but the message in a string stays the same
#	Same you wan to have a message that says 'Nice to meet you ___. I am ___'
#	The number 0 here represents the argument in our format function.
#	Since title is the first item in the argument, that will fill in the value 0 within the curly brackets
title = 'pythonBo'
machine = 'HAL'
'Nice to meet you {0}. I am {1}'.format(title, machine)

#	Python 3.6 has introduced string interpolation so now you can do something like this
#	This presents an alternative to using the format function
f'Nice to meet you {title}. I am {machine}'

# 	note the prefix f at the start and the variable names in the curly brackets
#	This isn't the only time a character prefix is used
#	r to indicate raw string so python does not escape backslashes
#	u  to tell python that unicode is in use
