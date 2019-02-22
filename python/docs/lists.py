

#############
# Lists
#############

# Index in Python starts at 0
singers = ['れをる', 'あいみょん', 'えなこ', 'みゆな']

# Lists can take in more than one data typ
numbers = ['れをる', str(2), True, str(1.256)]

# Prints the entire list values
print(singers)

# Prints the index value from the list
print(singers[0])

# Prints the values from the list starting with the given index
print(singers[2:])

# Prints from a range of index values in a given list
print(singers[1:3])

# Replaces the index value with another value
singers[1] = '鈴木里奈'
print(singers[1])

# Extends a list by adding another list to the existing
singers.extend(numbers)
print(singers)

# Appends a single item to the end of an existing list
singers.append('さやか')
print(singers)

# Inserts a single list item into a specified index value
singers.insert(0, 'まみ佐崎')
print(singers)

# Removes a single item from a list
singers.remove(True)
print(singers)

# Removes/pops the last element of a list
singers.pop()
print(singers)

# Checks to see if a certain item is within a list. 
# If there are more than one instance, it prints out the first occurrence
print(singers.index('みゆな'))

# Counts the number of instance in a specified value appears inside a list
print(singers.count('れをる'))

# Sorts a list in ascending order. Does not work if the list contains more tha one datatype
singers.sort()
print(singers)

# Reverses the order of a list
singers.reverse()
print(singers)

# Creates a copy of a list
singers2 = singers.copy()
singers2.extend(singers)
print(singers2)

# Clears an entire list/Empties a list
singers.clear()
print(singers)

