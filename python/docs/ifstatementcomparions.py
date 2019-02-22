
##################
# If Statements Comparison
##################


# If statement that compares different values and prints the largest of three provided argument values
def max_num(num1, num2, num3):
    if num1 >= num2 and num1 >= num3:
        return num1
    elif num2 >= num1 and num2 >= num3:
        return num2
    else:
        return num3


result = max_num(300, 40, 5)
print(result)


# TODO: String comparisons
def max_num(num1, num2, num3):
    if num1 == num2 and num1 >= num3:
        return num1
    elif num2 >= num1 and num2 >= num3:
        return num2
    else:
        return num3
