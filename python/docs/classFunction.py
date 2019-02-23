
#################
# Classes
#################


# Class essentially allows us to create our own data type
class Student:
    # Maps out what attributes a student will have
    def __init__(self, name, major, gpa):
        self.name = name
        self.major = major
        self.gpa = gpa

    # Function for
    def on_honor_roll(self):
        if self.gpa >= 3.5:
            return True
        else:
            return False
