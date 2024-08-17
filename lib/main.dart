import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages/questions_page.dart'; // Update with your correct path
import 'pages/results_page.dart'; // Update with your correct path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/questions': (context) => QuestionsPage(questions: []), // This will be updated dynamically
        '/results': (context) => ResultsPage(correctAnswers: 0, totalQuestions: 0), // Placeholder
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  Future<void> _fetchQuestionsAndNavigate(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/questions'));
      if (response.statusCode == 200) {
        List<dynamic> questions = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionsPage(questions: questions),
          ),
        );
      } else {
        print('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _fetchQuestionsAndNavigate(context),
          child: Text('Start Quiz'),
        ),
      ),
    );
  }
}
