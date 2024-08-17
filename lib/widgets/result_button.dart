import 'package:flutter/material.dart';

class ResultButton extends StatelessWidget {
  final VoidCallback onTap;

  ResultButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text('Back to Quiz'),
    );
  }
}
