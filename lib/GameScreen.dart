import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameModelProvider.dart';
import 'constants.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String characters = 'abcdefghijklmnopqrstuvwxyz'.toUpperCase();
  late String words;
  List<String> selectedChar = [];
  int tries = 0;
  late String hint;
  List<String> revealedLetters = [];

  void updateRevealedLetters() {
    for (int i = 0; i < words.length; i++) {
      String char = words[i];
      if (selectedChar.contains(char) && !revealedLetters.contains(char)) {
        setState(() {
          revealedLetters.add(char);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = context.read<GameModelProvider>();
    words = provider.guessWord.toUpperCase();
    hint = provider.hint;
    revealedLetters = provider.revealedLetters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                          padding: const EdgeInsets.all(30),
                          child: Stack(
                            children: [
                              buildHangMan(tries >= 0, HangManParts.pole),
                              buildHangMan(tries >= 1, HangManParts.head),
                              buildHangMan(tries >= 2, HangManParts.body),
                              buildHangMan(tries >= 3, HangManParts.leftHand),
                              buildHangMan(tries >= 4, HangManParts.rightHand),
                              buildHangMan(tries >= 5, HangManParts.leftLeg),
                              buildHangMan(tries >= 6, HangManParts.rightLeg),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text('HINT : $hint', overflow: TextOverflow.fade, maxLines: 1, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            width: double.infinity,
                            color: Colors.teal,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  runSpacing: 5,
                                  spacing: 10,
                                  children: words
                                      .split('')
                                      .map((e) => hiddenLetter(
                                          e,
                                    !selectedChar.contains(e),
                                    revealedLetters
                                          ))
                                      .toList(),
                                ),
                              ),
                            )))
                  ],
                )),
            Expanded(
                child: Container(
              color: Colors.deepPurple,
              child: GridView.count(
                padding: const EdgeInsets.all(12),
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 6,
                children: characters
                    .split('')
                    .map((e) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: Colors.black),
                        onPressed: selectedChar.contains(e)
                            ? null
                            : () {
                                setState(() {
                                  selectedChar.add(e);
                                  if (!words.contains(e)) {
                                    tries++;
                                  }
                                  updateRevealedLetters();

                                });
                        },
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 24),
                        )))
                    .toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

Widget hiddenLetter(String char, bool visible, List<String> revealedLetters) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12)),
    alignment: Alignment.center,
    child: Visibility(
      visible: !visible || revealedLetters.contains(char.toLowerCase()),
      child: Text(
        char,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildHangMan(bool visible, String path) {
  return Visibility(
    visible: visible,
    child: Image.asset(path),
  );
}
