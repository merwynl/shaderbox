
#################
# File Read
#################

# Reads the information from a relative path. Encoding needs to be specified here if unicode characters are being used
singer_file = open('singers.txt', 'r', encoding='utf-8')

# Write information to a file exiting inside a relative path
open('singers.txt', 'w')

# Appends new information to an exiting file inside a relative path
open('singers.txt', 'a')

# Full read write access to a file
states = open('states.txt', 'r+')

# Prints out if a file is readable or not
print(singer_file.readable())

# Reads a single line from a file. Requires at least two entries for it to work
print(singer_file.readline())

# Reads all the lines from a file and puts them into a list
print(singer_file.readlines())

# Reads a single line based on an index value
print(singer_file.readlines()[1])

# Reads each line and for each line, prints them out
for state in states.readlines():
    print(state) 

# Alternate method of reading & printing data from an external file
for state in states:
    print(state) 

# Reads & prints out everything in a given file. Does not work if other two types of errors exist
print(states.read())

# Closes the file. Always close a file after it's been opened
singer_file.close()
states.close()

