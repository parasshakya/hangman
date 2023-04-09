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
    wordToGuess = gameModelProvider.guessWord;
  }
  Set<int> selectedChipIndices = {};


  @override
  Widget build(BuildContext context) {
    print(revealedLetters);

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Choose letters to reveal to the other player'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            // children: wordToGuess
            //     .split('')
            //     .map((letter) => ChoiceChip(
            //           label: Text(letter),
            //           selected: isChipSelected,
            //           onSelected: isChipSelected ?
            //              null
            //               : (selected) {
            //             if (selected) {
            //               revealedLetters.add(letter);
            //               context.read<GameModelProvider>().setRevealedLetters(revealedLetters);
            //               setState(() {
            //                 isChipSelected = true;
            //               });
            //             }
            //           },
            //           selectedColor: Colors.red,
            //           disabledColor: Colors.grey,
            //         ))
            //     .toList(),
            children: List.generate(wordToGuess.length, (index) {
              return ChoiceChip(
                label: Text(wordToGuess.split('')[index]),
                selected: selectedChipIndices.contains(index),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      revealedLetters.add(wordToGuess.split('')[index]);
                      context.read<GameModelProvider>().setRevealedLetters(revealedLetters);

                      // add the index of the selected chip to the set
                    selectedChipIndices.add(index);

                  } else {
                      context.read<GameModelProvider>().removeRevealedLetters(wordToGuess.split('')[index]);

                      // remove the index of the deselected chip from the set
                    selectedChipIndices.remove(index);
                  }
                  });
                },
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GameScreen()));
            },
            child: const Text('Next'),
          ),
        ]),
      ),
    );
  }
}
