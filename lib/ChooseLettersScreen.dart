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
   List<int> revealedIndices = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final gameModelProvider = context.read<GameModelProvider>();
    wordToGuess = gameModelProvider.guessWord;
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Choose letters to reveal to the other player'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: List.generate(wordToGuess.length, (index) {
              if(wordToGuess.split('')[index] == ' '){
                return const Text(' ');
              }else{
                return ChoiceChip(
                  label: Text(wordToGuess.split('')[index]),
                  selected: revealedIndices.contains(index),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                          revealedIndices.add(index);
                        // add the index of the selected chip to the list
                        context.read<GameModelProvider>().setRevealedIndices(revealedIndices);

                      } else {

                        // remove the index of the deselected chip
                        context.read<GameModelProvider>().removeRevealedIndices(index);

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
              if (revealedIndices.isEmpty) {
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
              } else if (revealedIndices.length == wordToGuess.replaceAll(' ', '').length) {
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
