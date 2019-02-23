from chef import Chef

# Inherits from chef class
class JapaneseChef(Chef):

    def make_special_dish(self):
        print('The chef makes ramen')

    def make_sushi(self):
        print('The chef makes sushi')