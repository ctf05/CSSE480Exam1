import 'dart:async';
import 'dart:math';

class MatchingGame {
  late List<String> cards;
  late String cardBack;
  final int numPairs;
  late List<bool> flippedCards;
  late List<bool> matchedCards;
  int? firstFlippedIndex;
  int? secondFlippedIndex;
  Timer? flipBackTimer;

  final allEmojiCharacters = "🚁,🐴,🐇,🐢,🐱,🐌,🐒,🐞,🐫,🐠,🐬,🐩,🐶,🐰,🐼,⛄,🌸,⛅,🐸,🐳,❄,❤,🐝,🌺,🌼,🌽,🍌,🍎,🍡,🏡,🌻,🍉,🍒,🍦,👠,🐧,👛,🐛,🐘,🐨,😃,🐻,🐹,🐲,🐊,🐙".split(",");
  final allCardBacks = "🎆,🎇,🌅,🌇,🌉,🌃,🌄,🌌".split(",");

  MatchingGame(this.numPairs) {
    newGame();
  }

  void newGame() {
    List<String> selectedEmojis = (allEmojiCharacters..shuffle()).take(numPairs).toList();
    cards = [...selectedEmojis, ...selectedEmojis]..shuffle();
    cardBack = (allCardBacks..shuffle()).first;
    flippedCards = List.filled(numPairs * 2, false);
    matchedCards = List.filled(numPairs * 2, false);
    firstFlippedIndex = null;
    secondFlippedIndex = null;
    flipBackTimer?.cancel();
    flipBackTimer = null;
    _printCheatSheet();
  }

  bool flipCard(int index) {
    if (matchedCards[index] || flippedCards[index]) return false;

    if (firstFlippedIndex == null) {
      firstFlippedIndex = index;
      flippedCards[index] = true;
      return true;
    } else if (secondFlippedIndex == null && index != firstFlippedIndex) {
      secondFlippedIndex = index;
      flippedCards[index] = true;
      return true;
    }
    return false;
  }

  bool checkMatch() {
    if (firstFlippedIndex != null && secondFlippedIndex != null) {
      return cards[firstFlippedIndex!] == cards[secondFlippedIndex!];
    }
    return false;
  }

  void processMatch() {
    if (checkMatch()) {
      matchedCards[firstFlippedIndex!] = true;
      matchedCards[secondFlippedIndex!] = true;
    } else {
      flippedCards[firstFlippedIndex!] = false;
      flippedCards[secondFlippedIndex!] = false;
    }
    firstFlippedIndex = null;
    secondFlippedIndex = null;
  }

  bool isGameOver() {
    return matchedCards.every((matched) => matched);
  }

  void _printCheatSheet() {
    print("Cheat Sheet:");
    int cols = 4;
    String horizontalLine = "-" * (4 * cols + 1);
    print(horizontalLine);
    for (int i = 0; i < cards.length; i += cols) {
      String rowString = "| ";
      for (int j = 0; j < cols && i + j < cards.length; j++) {
        rowString += "${cards[i + j].padRight(2)} | ";
      }
      print(rowString);
      print(horizontalLine);
    }
  }
}