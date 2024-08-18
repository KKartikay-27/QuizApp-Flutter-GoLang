import 'package:flutter/material.dart';
import 'results_page.dart';

class QuestionsPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  QuestionsPage({required this.questions});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _isAnswered = false;
  bool _showExplanation = false;
  int? selectedOptionIndex;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Duration of animation
    );

    // Initialize Tween for progress animation
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: (_currentQuestionIndex + 1) / widget.questions.length,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start with the correct initial progress
    _animationController.forward(from: 0.0);
  }

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

        // Update animation
        _progressAnimation = Tween<double>(
          begin: _currentQuestionIndex / widget.questions.length,
          end: (_currentQuestionIndex + 1) / widget.questions.length,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        _animationController.forward(from: 0.0);
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    final options = question['options'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}'),
      ),
      body: Column(
        children: [
          // Smooth progress bar at the top
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressAnimation.value,
                backgroundColor: Colors.grey[300],
                color: Colors.purple[500],
                minHeight: 8.0,
              );
            },
          ),
          Expanded(
            child: Padding(
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
                              ? Colors.purple[200]
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
          ),
        ],
      ),
    );
  }
}
