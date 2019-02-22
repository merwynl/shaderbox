
#################
# File Write
#################

singer_file = open('singers.txt', 'r', encoding='utf-8')
print(singer_file.read())
singer_file.close()