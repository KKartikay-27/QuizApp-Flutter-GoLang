import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/welcome_page.dart';
import 'pages/results_page.dart';

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
      home: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Failed to load questions')),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Navigate to ResultsPage if no questions are available
            return ResultsPage(correctAnswers: 0, totalQuestions: 0);
          } else {
            // Navigate to WelcomePage with the fetched questions
            return WelcomePage(questions: snapshot.data!);
          }
        },
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> fetchQuestions() async {
  final response = await http.get(Uri.parse('https://quizapp-flutter-golang.onrender.com/questions'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => item as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load questions');
  }
}
