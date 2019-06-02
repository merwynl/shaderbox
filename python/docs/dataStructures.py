
#######################
# Data Structures
#######################


# combining data types
def add_numbers(a: int, b: int):
    print(a + b)


# type hinting
def type_hint(a: int, b: int) -> int:
    return a + b


# variables containing floats and ints
# type conversion included in line 19 and 20
base = 42
pi = 3.14159
answer = 45.14159  # Don't worry about conversion
var1 = int(base) == 3
var2 = float(answer) == 42.0

# Booleans
# Most often used in if statements or flags to denote whether something is true or false
# Boolean values must begin with a capital T or F
python = True
js = False
int(python) == 1
int(js) == 0
str(python) == 'True'
print(str(python))
