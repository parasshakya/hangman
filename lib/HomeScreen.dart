import 'package:flutter/material.dart';
import 'package:hangman/ChooseLettersScreen.dart';
import 'package:provider/provider.dart';
import 'package:hangman/GameModelProvider.dart';

import 'GameScreen.dart';

class HintPage extends StatefulWidget {
  @override
  _HintPageState createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {
  final TextEditingController _guessWordController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();

  void _startGame(BuildContext context) {
    // Get the current values of the guess word and hint from the text fields
    final String guessWord = _guessWordController.text;
    final String hint = _hintController.text;

    // Update the values in the GameModel using the provider package
    final GameModelProvider gameModelProvider =
        Provider.of<GameModelProvider>(context, listen: false);
    gameModelProvider.setHint(hint);
    gameModelProvider.setGuessWord(guessWord);

    // Navigate to the game screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseLetterScreen()),
    );
  }

  @override
  void dispose() {
    _guessWordController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter a word for your opponent to guess:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _guessWordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g. Flutter',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Enter a hint to help your opponent:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _hintController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g. A cross-platform mobile development framework',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _startGame(context),
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
