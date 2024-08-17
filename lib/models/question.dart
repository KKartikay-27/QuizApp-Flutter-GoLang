import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final String questionText;
  final List<String> options;
  final Map<String, String> explanations;

  Question({
    required this.questionText,
    required this.options,
    required this.explanations,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
