
import 'package:material_ui/material_ui.dart';
import '../data/questions.dart';
import '../widgets/answer_button.dart';

class QuizScreen extends StatefulWidget {
  final Function(int) onFinish;

  const QuizScreen({super.key, required this.onFinish});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> quizQuestions = [];

  int questionIndex = 0;
  int score = 0;
  bool answered = false;
  String selectedAnswer = '';

  @override
  void initState() {
    super.initState();

    quizQuestions = List<Map<String, dynamic>>.from(questions);
    quizQuestions.shuffle();
    quizQuestions = quizQuestions.take(10).toList();
  }

  void checkAnswer(String answer) {
    if (answered == false) {
      setState(() {
        selectedAnswer = answer;
        answered = true;

        if (answer == quizQuestions[questionIndex]['correct']) {
          score++;
        }
      });
    }
  }

  void nextQuestion() {
    if (answered == true) {
      if (questionIndex == 9) {
        widget.onFinish(score);
      } else {
        setState(() {
          questionIndex++;
          answered = false;
          selectedAnswer = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[questionIndex];
    final answers = question['answers'];
    final correctAnswer = question['correct'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Road Signs Quiz',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text('Test your driving knowledge'),

          const SizedBox(height: 20),

          Text('Question ${questionIndex + 1} of 10'),

          const SizedBox(height: 10),

          LinearProgressIndicator(
            value: (questionIndex + 1) / 10,
            minHeight: 9,
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/signs/${question['image']}',
                  height: 175,
                ),

                const SizedBox(height: 20),

                Text(
                  question['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text('CHOOSE YOUR ANSWER'),

          const SizedBox(height: 15),

          for (int i = 0; i < answers.length; i++)
            AnswerButton(
              text: answers[i],
              letter: ['A', 'B', 'C', 'D'][i],
              answered: answered,
              isCorrect: answers[i] == correctAnswer,
              isSelected: answers[i] == selectedAnswer,
              onPressed: () {
                checkAnswer(answers[i]);
              },
            ),

          if (answered && selectedAnswer == correctAnswer)
            const Text(
              'Correct! Great job!',
              style: TextStyle(color: Colors.green),
            ),

          if (answered && selectedAnswer != correctAnswer)
            Text(
              'Incorrect! Correct answer: $correctAnswer',
              style: const TextStyle(color: Colors.red),
            ),

          const SizedBox(height: 20),

          if (answered)
            ElevatedButton(
              onPressed: nextQuestion,
              child: Text(
                questionIndex == 9
                    ? 'See Results'
                    : 'Next Question',
              ),
            ),

          const SizedBox(height: 20),

          Text('Current Score: $score'),
        ],
      ),
    );
  }
}
