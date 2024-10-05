import 'package:flutter/material.dart';
import '../models/matching_game.dart';
import 'card_widget.dart';

class CardGrid extends StatelessWidget {
  final MatchingGame game;
  final Function(int) onCardTap;

  const CardGrid({Key? key, required this.game, required this.onCardTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
          ),
          itemCount: game.cards.length,
          itemBuilder: (context, index) {
            return CardWidget(
              emoji: game.cards[index],
              cardBack: game.cardBack,
              isFlipped: game.flippedCards[index],
              isMatched: game.matchedCards[index],
              onTap: () => onCardTap(index),
            );
          },
        ),
      ),
    );
  }
}