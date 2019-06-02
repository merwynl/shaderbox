
##################
# Advanced Calculator
##################

num1 = float(input('数字を入力してください：　'))
op = input('どんな演算子使いますか：　')
num2 = float(input('他の数字を入力してください：　'))

if op == '+':
    print(num1 + num2)
elif op == '-':
    print(num1 - num2)
elif op == '/':
    print(num1 / num2)
elif op == '*':
    print(num1 * num2)
else:
    print('No matching operator')
