from chef import Chef

# Inherits from chef class
class ItalianChef(Chef):  

    def make_special_dish(self):
        print('The chef makes lasagna')

    def make_pasta(self):
        print('The chef makes pasta')