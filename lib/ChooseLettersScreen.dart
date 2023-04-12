import 'package:flutter/material.dart';
import 'package:hangman/GameModelProvider.dart';
import 'package:hangman/GameScreen.dart';
import 'package:provider/provider.dart';

class ChooseLetterScreen extends StatefulWidget {
  @override
  State<ChooseLetterScreen> createState() => _ChooseLetterScreenState();
}

class _ChooseLetterScreenState extends State<ChooseLetterScreen> {
  late String wordToGuess;
  List<String> revealedLetters = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    revealedLetters.clear();
    final gameModelProvider = context.read<GameModelProvider>();
    wordToGuess = gameModelProvider.guessWord.toLowerCase();
  }

  Set<int> selectedChipIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Choose letters to reveal to the other player'),
          const SizedBox(
            height: 10,
          ),
          const Text(
              'Choosing a repeating letter will select all the repeated letters', textAlign: TextAlign.center,),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: List.generate(wordToGuess.length, (index) {
              if (wordToGuess.split('')[index] == ' ') {
                return const Text(' ');
              } else {
                return ChoiceChip(
                  label: Text(wordToGuess.split('')[index]),
                  selected: selectedChipIndices.contains(index),
                  onSelected: (bool selected) {
                    setState(() {
                      String letter = wordToGuess.split('')[index];

                      if (selected) {
                        revealedLetters.add(wordToGuess.split('')[index]);
                        context
                            .read<GameModelProvider>()
                            .setRevealedLetters(revealedLetters);
                        // add the index of the selected chip to the set
                        selectedChipIndices.addAll(wordToGuess
                            .split('')
                            .asMap()
                            .entries
                            .where((entry) => entry.value == letter)
                            .map((entry) => entry.key));
                      } else {
                        context.read<GameModelProvider>().removeRevealedLetters(
                            wordToGuess.split('')[index]);
                        // remove the index of the deselected chip from the set
                        selectedChipIndices.removeAll(wordToGuess
                            .split('')
                            .asMap()
                            .entries
                            .where((entry) => entry.value == letter)
                            .map((entry) => entry.key));
                      }
                    });
                  },
                );
              }
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedChipIndices.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sorry !'),
                      content: const Text('Please select at least one letter.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (selectedChipIndices.length ==
                  wordToGuess.replaceAll(' ', '').length) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sorry !'),
                      content: const Text('You cannot select all the letters.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GameScreen()));
              }
            },
            child: const Text('Next'),
          ),
        ]),
      ),
    );
  }
}
