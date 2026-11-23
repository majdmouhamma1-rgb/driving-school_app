
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
    final int percentage =
        total == 0 ? 0 : ((score / total) * 100).round();

    final bool passed = percentage >= 70;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                passed ? '🏆' : '📚',
                style: const TextStyle(fontSize: 65),
              ),
              const SizedBox(height: 15),
              Text(
                passed ? 'Congratulations!' : 'Keep Practicing!',
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
                  color: passed ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You answered $score out of $total questions correctly.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                passed ? 'You Passed!' : 'You Did Not Pass',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: passed ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRestart,
                  child: const Text('Try Again'),
                ),
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
