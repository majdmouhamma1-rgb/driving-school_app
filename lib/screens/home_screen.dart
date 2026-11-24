
import 'package:material_ui/material_ui.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const HomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
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
              const Text(
                '🚗',
                style: TextStyle(fontSize: 65),
              ),

              const SizedBox(height: 20),

              const Text(
                'Majd Driving School',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Driving License Practice Test',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2563EB),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Test your knowledge of traffic signs and '
                'prepare for your driving license exam.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 25),

              const Text('📝 10 Questions'),
              const SizedBox(height: 10),
              const Text('🚦 Traffic Signs'),
              const SizedBox(height: 10),
              const Text('🏆 Instant Results'),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onStart,
                  child: const Text('Start Practicing'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
