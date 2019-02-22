
##################
# Translator
##################


"""
Uses an if statement inside a for loop to determine if a character exists, if it does, it converts the character into something else
Adds secondary if statement that respects character case
"""


def translate(phrase):
    translation = ''
    for letter in phrase:
        if letter.lower() in 'aieou':
            if letter.isupper(): 
                translation = translation + 'G'
            else:
                translation = translation + 'g'
        else:
            translation = translation + letter
    return translation


print(translate((input('Enter a phrase: '))))
