
#################
# File Write
#################

# Appends a new string to an existing text file in a new line
state_file = open('states.txt', 'a', encoding='utf-8')
state_file.write('\nIsland - Miyajima')
state_file.close()

# Writes data to a file. If that file does not already exists, it creates one
state_new_file = open('log.txt', 'w', encoding='utf-8')
state_new_file.write('\nIsland - Miyajima')
state_new_file.close()
