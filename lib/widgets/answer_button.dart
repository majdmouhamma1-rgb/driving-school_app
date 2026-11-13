
import 'package:flutter/material.dart';

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
    Color border = const Color(0xFFE2E8F0);
    Color foreground = const Color(0xFF0F172A);

    if (answered && isCorrect) {
      background = const Color(0xFFDCFCE7);
      border = const Color(0xFF22C55E);
      foreground = const Color(0xFF166534);
    } else if (answered && isSelected) {
      background = const Color(0xFFFEE2E2);
      border = const Color(0xFFEF4444);
      foreground = const Color(0xFF991B1B);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: answered ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: border, width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: border,
                  child: Text(
                    letter,
                    style: TextStyle(
                      color: answered && (isCorrect || isSelected)
                          ? foreground
                          : const Color(0xFF475569),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: foreground,
                    ),
                  ),
                ),
                if (answered && isCorrect)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF16A34A),
                  ),
                if (answered && isSelected && !isCorrect)
                  const Icon(
                    Icons.cancel,
                    color: Color(0xFFDC2626),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
