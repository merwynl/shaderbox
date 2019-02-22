
##################
# Exponents
##################

# Basic exponent
print('Built in Py Exponent = ' + str(3**2))


# Exponent function
def raise_to_power(base_num, pow_num):
    result = 1
    # Runs through the loop as many times as the given pow_num
    for index in range(pow_num):
        result = result * base_num   
    return result


print(raise_to_power(4, 2))
