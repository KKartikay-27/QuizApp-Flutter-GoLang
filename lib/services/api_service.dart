import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/question.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8080'; // Use 10.0.2.2 for Android emulators

  static Future<List<Question>> getQuestions() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/questions'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Question(
          questionText: item['questionText'],
          options: List<String>.from(item['options']),
          correctOptionIndex: item['correctOptionIndex'],
        )).toList();
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
