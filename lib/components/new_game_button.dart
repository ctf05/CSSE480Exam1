import 'package:flutter/material.dart';

class NewGameButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewGameButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('New Game'),
    );
  }
}