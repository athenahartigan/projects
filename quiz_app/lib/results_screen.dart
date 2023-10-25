import 'package:flutter/material.dart';

import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';


class ResultsScreen extends StatelessWidget {
  ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;
  final _controller = ConfettiController(duration: const Duration(seconds: 2));

  void onCelebrate() {
    _controller.play();
  }

  

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    final double percentRight = numCorrectQuestions/numTotalQuestions * 100;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 50,
              minBlastForce: 10,
              numberOfParticles: 100,
              //canvas: const Size(400,300),
              maximumSize: const Size(27,27),
              minimumSize: const Size(8,8),
              colors: const [
                Color.fromARGB(255, 255, 139, 178),
                Color.fromARGB(255, 166, 127, 252),
                Color.fromARGB(255, 185, 226, 255),
                Color.fromARGB(234, 63, 95, 255),
                Color.fromARGB(255, 150, 255, 148),
                Color.fromRGBO(142, 251, 216, 1),
                Color.fromARGB(216, 133, 12, 255),
                Color.fromARGB(175, 61, 154, 42),
                Color.fromARGB(255, 255, 42, 227),
                Color.fromARGB(255, 248, 255, 166),
                Color.fromARGB(255, 255, 222, 162),
                Color.fromARGB(255, 255, 233, 238),
                Colors.white,
              ],
            ),
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 53, 1, 93),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            percentRight >= 75 
              ? TextButton.icon(
                onPressed: onCelebrate,
                
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 27, 2, 125),
                  backgroundColor: const Color.fromARGB(255, 201, 239, 255),
                ),
                icon: const Icon(Icons.celebration_outlined),
                label: const Text('Celebrate!'),
              )
              : Text(
                'Try again, you got this!',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 53, 1, 93),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 27, 2, 125),
                  backgroundColor: const Color.fromARGB(255, 201, 239, 255),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Restart Quiz!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}