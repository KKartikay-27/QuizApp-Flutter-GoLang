import 'package:flutter/material.dart';
import 'welcome_page.dart';

class ResultsPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultsPage({required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50], // Light purple background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Quiz Results',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800], // Darker purple color for the text
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You got $correctAnswers out of $totalQuestions correct!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[700], // Darker purple color for the text
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text('Return to Home'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
