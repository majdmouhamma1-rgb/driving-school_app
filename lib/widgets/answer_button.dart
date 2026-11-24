
import 'package:material_ui/material_ui.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final String letter;
  final bool answered;
  final bool isCorrect;
  final bool isSelected;
  final VoidCallback onPressed;

  const AnswerButton({
    super.key,
    required this.text,
    required this.letter,
    required this.answered,
    required this.isCorrect,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color background = Colors.white;

    if (answered && isCorrect) {
      background = Colors.green.shade100;
    } else if (answered && isSelected) {
      background = Colors.red.shade100;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: answered ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: background,
            disabledBackgroundColor: background,
            foregroundColor: Colors.black,
            disabledForegroundColor: Colors.black,
            padding: const EdgeInsets.all(16),
          ),
          child: Text('$letter. $text'),
        ),
      ),
    );
  }
}
