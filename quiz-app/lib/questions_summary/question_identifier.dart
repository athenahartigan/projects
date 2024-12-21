import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  QuestionIdentifier({
    super.key,
    required this.isCorrectAnswer,
    required this.questionIndex,
  });

  final int questionIndex;
  final bool isCorrectAnswer;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;

    
    return Stack(
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCorrectAnswer
                ? const Color.fromARGB(255, 137, 195, 126)
                : const Color.fromARGB(255, 253, 115, 115),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            questionNumber.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }
}
