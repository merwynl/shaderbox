
#################
# Try / Except
#################

# Try's & excepts are useful for catching any potential errors & prevents a program from crashing
try:
    # answer = 10/0
    number = int(input('数字を入力してください: '))
    print(number)

# Without a specified clause, it will catch any and all errors. ZeroDivisionError catches if a return value is 0
except ZeroDivisionError as err:
    print('ゼロから割れ切れています')
    print(err)

# Without a specified clause, it will catch any and all errors
except ValueError:
    print('申し訳ございます。それは数字ではありません')

