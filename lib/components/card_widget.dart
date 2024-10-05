import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String emoji;
  final String cardBack;
  final bool isFlipped;
  final bool isMatched;
  final VoidCallback onTap;

  const CardWidget({
    Key? key,
    required this.emoji,
    required this.cardBack,
    required this.isFlipped,
    required this.isMatched,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMatched) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text(
          isFlipped ? emoji : cardBack,
          style: const TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}