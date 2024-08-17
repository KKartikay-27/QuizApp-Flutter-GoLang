import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pages/questions_page.dart'; // Update with your correct path

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
        // Handle errors here
      }
    } catch (e) {
      // Handle errors here
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
