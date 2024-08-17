import 'package:flutter/material.dart';
import 'package:quizapp/pages/results_page.dart'; // Ensure this import is correct

class QuestionsPage extends StatefulWidget {
  final List<dynamic> questions;

  QuestionsPage({required this.questions});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentQuestionIndex = 0;
  bool answerChecked = false;
  int? selectedOptionIndex;
  int? correctAnswer;
  int correctAnswers = 0;

  void _selectOption(int index) {
    if (!answerChecked) {
      setState(() {
        selectedOptionIndex = index;
        answerChecked = true;
        correctAnswer = widget.questions[currentQuestionIndex]['answer'];
        if (selectedOptionIndex == correctAnswer) {
          correctAnswers++;
        }
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      answerChecked = false;
      selectedOptionIndex = null;
      currentQuestionIndex++;
      if (currentQuestionIndex >= widget.questions.length) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              correctAnswers: correctAnswers,
              totalQuestions: widget.questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Questions'),
        ),
        body: Center(
          child: Text('No questions available.'),
        ),
      );
    }

    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Questions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ...question['options'].asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              bool isSelected = selectedOptionIndex == index;
              bool isCorrect = index == correctAnswer;
              Color backgroundColor = Colors.transparent;

              if (answerChecked) {
                if (isSelected) {
                  backgroundColor = isCorrect ? Colors.green : Colors.red;
                } else if (index == correctAnswer) {
                  backgroundColor = Colors.green;
                }
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  onPressed: () => _selectOption(index),
                  child: Text(option),
                ),
              );
            }).toList(),
            SizedBox(height: 20.0),
            if (answerChecked)
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text(currentQuestionIndex < widget.questions.length - 1 ? 'Next Question' : 'See Results'),
              ),
          ],
        ),
      ),
    );
  }
}
