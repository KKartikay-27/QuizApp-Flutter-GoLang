import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultsPage({
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center( // Center the content vertically and horizontally
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content within the column
            children: [
              Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                'Correct Answers: $correctAnswers',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Total Questions: $totalQuestions',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
