
import 'package:material_ui/material_ui.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(const DrivingApp());
}

class DrivingApp extends StatelessWidget {
  const DrivingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Majd Driving School',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
          ),
        ),
      ),
      home: const DrivingPage(),
    );
  }
}

class DrivingPage extends StatefulWidget {
  const DrivingPage({super.key});

  @override
  State<DrivingPage> createState() => _DrivingPageState();
}

class _DrivingPageState extends State<DrivingPage> {
  int page = 0;
  int score = 0;

  void startQuiz() {
    setState(() {
      page = 1;
    });
  }

  void finishQuiz(int finalScore) {
    setState(() {
      score = finalScore;
      page = 2;
    });
  }

  void goHome() {
    setState(() {
      page = 0;
    });
  }

  Widget showPage() {
    if (page == 0) {
      return HomeScreen(onStart: startQuiz);
    } else if (page == 1) {
      return QuizScreen(onFinish: finishQuiz);
    } else {
      return ResultScreen(
        score: score,
        total: 10,
        onRestart: startQuiz,
        onHome: goHome,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DRIVE SMART',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: showPage(),
    );
  }
}
