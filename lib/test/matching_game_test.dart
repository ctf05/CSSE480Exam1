import 'package:flutter_test/flutter_test.dart';
import 'package:exam1flutter/models/matching_game.dart';

void main() {
  group('MatchingGame', () {
    test('Constructor initializes game correctly', () {
      final game = MatchingGame(10);
      expect(game.cards.length, equals(20));
      expect(game.flippedCards.length, equals(20));
      expect(game.matchedCards.length, equals(20));
      expect(game.cardBack, isNotEmpty);
    });

    test('flipCard changes card state', () {
      final game = MatchingGame(10);
      game.flipCard(0);
      expect(game.flippedCards[0], isTrue);
    });

    test('checkMatch identifies correct matches', () {
      final game = MatchingGame(10);
      int matchIndex = -1;
      for (int i = 1; i < game.cards.length; i++) {
        if (game.cards[i] == game.cards[0]) {
          matchIndex = i;
          break;
        }
      }
      game.flipCard(0);
      game.flipCard(matchIndex);
      expect(game.checkMatch(), isTrue);
    });

    test('isGameOver returns true when all cards are matched', () {
      final game = MatchingGame(10);
      for (int i = 0; i < game.matchedCards.length; i++) {
        game.matchedCards[i] = true;
      }
      expect(game.isGameOver(), isTrue);
    });

    test('newGame resets the game state', () {
      final game = MatchingGame(10);
      game.flipCard(0);
      game.flipCard(1);
      game.checkMatch();
      game.newGame();
      expect(game.flippedCards.every((flipped) => !flipped), isTrue);
      expect(game.matchedCards.every((matched) => !matched), isTrue);
    });
  });
}