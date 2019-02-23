
# Gets the Student class from classes.py
from classes import Student

# Creates an object. An object is an instance of a class. They are similar to child-blueprints
student1 = Student('れをる', 'ボカロイド', 4.5, False)
student2 = Student('えなこ', '声優', 3.3, True)
student3 = Student('あいみょん', '歌手', 3.5, False)
student4 = Student('藤川', '歌手', 3.2, False)
student5 = Student('majiko', '歌い手', 3.4, True)

students = [student1, student2, student3, student4, student5]

for student in students:
    print(student.on_honor_roll())

# print(student3.on_honor_roll())
