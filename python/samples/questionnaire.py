from question import Question


question_prompts = [
    '団子の色はなんですか\n(a) 赤いか緑色\n(b) 紫色\n(c) オレンジ色\n\n',
    'バナナの色はなんですか\n(a) ティール色\n(b) マゼンタ色\n(c) 黄色\n\n',
    '苺の色はなんですか\n(a) 黄色\n(b) 赤い色\n(c) 青い色\n\n',
]

questions = [
    Question(question_prompts[0], 'a'),
    Question(question_prompts[1], 'c'),
    Question(question_prompts[2], 'b')
]


def run_test(questions):
    score = 0
    for question in questions:
        answer = input(question.prompt)
        if answer == question.answer:
            score += 1
    print('君が ' + str(score) + ' / ' + str(len(questions)) + ' 正解しました！')


run_test(questions)
