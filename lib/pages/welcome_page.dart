import 'package:flutter/material.dart';
import 'questions_page.dart';

class WelcomePage extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  WelcomePage({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionsPage(questions: questions),
              ),
            );
          },
          child: Text('Start Quiz'),
        ),
      ),
    );
  }
}
