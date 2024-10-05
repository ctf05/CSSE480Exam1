import 'package:flutter/material.dart';
import '../models/matching_game.dart';
import '../components/card_grid.dart';
import '../components/new_game_button.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late MatchingGame game;
  Timer? flipBackTimer;

  @override
  void initState() {
    super.initState();
    game = MatchingGame(10);
  }

  @override
  void dispose() {
    flipBackTimer?.cancel();
    super.dispose();
  }

  void _onCardTap(int index) {
    if (game.flipCard(index)) {
      setState(() {});

      if (game.secondFlippedIndex != null) {
        flipBackTimer?.cancel();
        flipBackTimer = Timer(const Duration(milliseconds: 1200), () {
          setState(() {
            game.processMatch();
          });
        });
      }
    }
  }

  void _startNewGame() {
    flipBackTimer?.cancel();
    setState(() {
      game.newGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji Matching'),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        color: Colors.deepPurple[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CardGrid(
                game: game,
                onCardTap: _onCardTap,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: NewGameButton(onPressed: _startNewGame),
            ),
          ],
        ),
      ),
    );
  }
}