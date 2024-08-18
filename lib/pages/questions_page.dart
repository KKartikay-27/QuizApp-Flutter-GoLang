import 'package:flutter/material.dart';
import 'results_page.dart';

class QuestionsPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  QuestionsPage({required this.questions});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _isAnswered = false;
  bool _showExplanation = false;
  int? selectedOptionIndex;

  void _submitAnswer() {
    if (selectedOptionIndex == null || _isAnswered) return; // Prevent multiple submissions
    setState(() {
      _isAnswered = true;
      if (selectedOptionIndex == widget.questions[_currentQuestionIndex]['answer']) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswered = false;
        _showExplanation = false;
        selectedOptionIndex = null;
      });
    } else {
      // Navigate to ResultsPage when last question is done
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            correctAnswers: _correctAnswers,
            totalQuestions: widget.questions.length,
          ),
        ),
      );
    }
  }

  void _toggleExplanation() {
    setState(() {
      _showExplanation = !_showExplanation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    final options = question['options'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question['question'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),
            ...options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              return GestureDetector(
                onTap: () {
                  if (!_isAnswered) {
                    setState(() {
                      selectedOptionIndex = index;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: _isAnswered
                        ? index == question['answer']
                        ? Colors.green
                        : index == selectedOptionIndex
                        ? Colors.red
                        : Colors.grey[300]
                        : (index == selectedOptionIndex
                        ? Colors.blue[100]
                        : Colors.grey[300]),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            if (!_isAnswered)
              ElevatedButton(
                onPressed: _submitAnswer,
                child: Text('Submit'),
              ),
            if (_isAnswered) ...[
              ElevatedButton(
                onPressed: _toggleExplanation,
                child: Text(_showExplanation ? 'Hide Explanation' : 'Show Explanation'),
              ),
              if (_showExplanation)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    question['explanation'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text(_currentQuestionIndex == widget.questions.length - 1
                    ? 'Show Results'
                    : 'Next Question'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
