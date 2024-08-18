import 'package:flutter/material.dart';
import 'questions_page.dart';

class WelcomePage extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  WelcomePage({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50], // Light purple background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Quiz App!',
              style: TextStyle(
                fontSize: 24, // Use a specific font size
                fontWeight: FontWeight.bold,
                color: Colors.purple[800], // Darker purple color for the text
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to QuestionsPage and pass questions as arguments
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionsPage(questions: questions),
                  ),
                );
              },
              child: Text('Start Quiz'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple), // Button color
                foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                elevation: MaterialStateProperty.all(10), // Shadow for the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
