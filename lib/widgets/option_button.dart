// lib/widgets/option_button.dart

import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const OptionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _selectOption(index),
      style: ElevatedButton.styleFrom(
        primary: isSelected
            ? (isCorrect ? Colors.green : Colors.red)
            : Colors.grey,
      ),
      child: Text(question.options[index]),
    );
  }
}
