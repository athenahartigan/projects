import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget{
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
              'assets/images/quiz-logo.png', 
            width: 300,
            color: const Color.fromARGB(255, 4, 73, 137),
          ),
          // Opacity(
          //   opacity: 0.6,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png', 
          //   width: 300,
          //   ),
          // ),
          const SizedBox(height: 60),
          Text('Breathe and Think Positively',
          style: GoogleFonts.lato(
            color: const Color.fromARGB(255, 142, 3, 248),
            fontSize: 24,
          ),
          ),
          const SizedBox(height: 60),
          OutlinedButton.icon(
            onPressed: startQuiz, 
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 249, 199, 245),
              backgroundColor: const Color.fromARGB(255, 3, 6, 100),
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz '),)
        ],
      ),
    );
  }
}