
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
    Color border = const Color(0xFFDBE3EF);

    if (answered && isCorrect) {
      background = const Color(0xFFDCFCE7);
      border = Colors.green;
    } else if (answered && isSelected) {
      background = const Color(0xFFFEE2E2);
      border = Colors.red;
    } else if (isSelected) {
      background = const Color(0xFFDBEAFE);
      border = const Color(0xFF2563EB);
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
            foregroundColor: const Color(0xFF0F172A),
            disabledForegroundColor: const Color(0xFF0F172A),
            padding: const EdgeInsets.all(16),
            side: BorderSide(color: border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xFFE2E8F0),
                child: Text(letter),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
