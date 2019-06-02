
##################
# Guessing Game
##################

secret_word = 'れをる'
guess = ''
guess_count = 0
guess_limit = 3
out_of_guesses = False

while guess != secret_word and not(out_of_guesses):
    if guess_count < guess_limit:
        print('暗示：音楽')
        guess = input('推測を入力してください: ')
        guess_count += 1
    else:
        out_of_guesses = True
if out_of_guesses:
    print('負けました！')
else:
    print('やったね！勝った！')
