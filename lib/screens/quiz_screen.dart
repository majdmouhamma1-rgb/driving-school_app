
import 'package:material_ui/material_ui.dart';
import '../data/questions.dart';
import '../widgets/answer_button.dart';

class QuizScreen extends StatefulWidget {
  final Function(int) onFinish;

  const QuizScreen({
    super.key,
    required this.onFinish,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Map<String, dynamic>> quizQuestions;

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
    if (answered) return;

    setState(() {
      selectedAnswer = answer;
      answered = true;

      if (answer == quizQuestions[questionIndex]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (!answered) return;

    if (questionIndex < quizQuestions.length - 1) {
      setState(() {
        questionIndex++;
        answered = false;
        selectedAnswer = '';
      });
    } else {
      widget.onFinish(score);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[questionIndex];
    final answers = List<String>.from(question['answers']);
    final String correctAnswer = question['correct'];
    final double progress =
        (questionIndex + 1) / quizQuestions.length;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Road Signs Quiz',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Test your driving knowledge',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${questionIndex + 1} of ${quizQuestions.length}',
                  ),
                  Text('${(progress * 100).round()}%'),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                minHeight: 9,
                backgroundColor: const Color(0xFFDBEAFE),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 175,
                      child: Image.asset(
                        'assets/images/signs/${question['image']}',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Image not found'),
                          );
                        },
                      ),
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
              const SizedBox(height: 24),
              const Text(
                'CHOOSE YOUR ANSWER',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              for (int i = 0; i < answers.length; i++)
                AnswerButton(
                  text: answers[i],
                  letter: String.fromCharCode(65 + i),
                  answered: answered,
                  isCorrect: answers[i] == correctAnswer,
                  isSelected: answers[i] == selectedAnswer,
                  onPressed: () => checkAnswer(answers[i]),
                ),
              if (answered)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    selectedAnswer == correctAnswer
                        ? 'Correct! Great job!'
                        : 'Incorrect! Correct answer: $correctAnswer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selectedAnswer == correctAnswer
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: answered ? nextQuestion : null,
                  child: Text(
                    questionIndex == quizQuestions.length - 1
                        ? 'See Results'
                        : 'Next Question',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text('Current Score: $score'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
