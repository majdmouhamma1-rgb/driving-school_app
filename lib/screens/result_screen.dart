
import 'package:material_ui/material_ui.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    int percentage = ((score / total) * 100).round();

    String message = 'Keep Practicing!';
    String emoji = '📚';
    String result = 'You Did Not Pass';
    Color resultColor = Colors.red;

    if (percentage >= 70) {
      message = 'Congratulations!';
      emoji = '🏆';
      result = 'You Passed!';
      resultColor = Colors.green;
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 65),
              ),

              const SizedBox(height: 15),

              Text(
                message,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'You answered $score out of $total questions correctly.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Text(
                result,
                style: TextStyle(
                  fontSize: 20,
                  color: resultColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: onRestart,
                child: const Text('Try Again'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: onHome,
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
