
#################
# Nested For Loops
#################

# Lists contained within a list. Each new list can be treated as a row and column
number_grid = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [0]
]

# For each row in the list, gets each column and for each value in each column, prints out that element
for row in number_grid:
    for column in row:
        print(column)
