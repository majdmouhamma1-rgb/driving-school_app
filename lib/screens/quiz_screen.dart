
import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

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
    quizQuestions = List.from(questions)..shuffle();
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            total: quizQuestions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[questionIndex];
    final List<String> answers =
        List<String>.from(question['answers']);

    final String correctAnswer = question['correct'];
    final double progress =
        (questionIndex + 1) / quizQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DRIVE SMART',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        leading: const Icon(
          Icons.directions_car_rounded,
          color: Color(0xFF2563EB),
        ),
      ),
      body: SafeArea(
        child: Center(
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
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Test your driving knowledge',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 26),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${questionIndex + 1} of ${quizQuestions.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 9,
                      backgroundColor: const Color(0xFFDBEAFE),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2563EB),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 175,
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Image.asset(
                            'assets/images/signs/${question['image']}',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image_outlined,
                                    size: 45,
                                    color: Colors.grey,
                                  ),
                                  Text('Image not found'),
                                ],
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
                            color: Color(0xFF0F172A),
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.3,
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: selectedAnswer == correctAnswer
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        selectedAnswer == correctAnswer
                            ? 'Correct! Great job!'
                            : 'Incorrect! Correct answer: $correctAnswer',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedAnswer == correctAnswer
                              ? const Color(0xFF166534)
                              : const Color(0xFF991B1B),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: answered ? nextQuestion : null,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: Text(
                      questionIndex == quizQuestions.length - 1
                          ? 'See Results'
                          : 'Next Question',
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      'Current Score: $score',
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
