import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'GameModelProvider.dart';
import 'constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen();

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String characters = 'abcdefghijklmnopqrstuvwxyz'.toUpperCase();
  late String words;
  List<String> selectedChar = [];
  int tries = 0;
  late String hint;
  late List<String> revealedLetters;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = context.read<GameModelProvider>();
    words = provider.guessWord.toLowerCase().replaceAll(' ', '');
    hint = provider.hint;
    revealedLetters = provider.revealedLetters;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Game?'),
        content: const Text('Are you sure you want to quit the game?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/homeScreen',
              (route) => false,
            ),
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    selectedChar.addAll(revealedLetters);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                                buildHangMan(
                                    tries >= 4, HangManParts.rightHand),
                                buildHangMan(tries >= 5, HangManParts.leftLeg),
                                buildHangMan(tries >= 6, HangManParts.rightLeg),
                              ],
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: Card(
                          color: Colors.blue.shade700,
                          child: Column(
                            children: [
                              SizedBox(height: 4,),
                              const Icon(
                                Icons.lightbulb,
                                color: Colors.yellowAccent,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  children:
                                      hint.split('').map((e) => Text(e
                                      ,
                                      style: GoogleFonts.raleway(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),)).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            width: double.infinity,
                            child: Center(
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  runSpacing: 3,
                                  spacing: 2,
                                  children: context
                                      .read<GameModelProvider>()
                                      .guessWord
                                      .split('')
                                      .map((e) => hiddenLetter(
                                          e,
                                          selectedChar
                                              .contains(e.toLowerCase()),
                                          revealedLetters))
                                      .toList(),
                                ),
                              ),
                          ))
                    ],
                  )),
              SizedBox(height: 10,),
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
                              padding: const EdgeInsets.all(5),
                              elevation: 0,
                              backgroundColor: Colors.black),
                          onPressed: selectedChar.contains(e.toLowerCase())
                              ? null
                              : () {
                                  setState(() {
                                    selectedChar.add(e.toLowerCase());
                                    if (!words.contains(e.toLowerCase())) {
                                      tries++;
                                    }
                                    if (words.toLowerCase().split('').every(
                                        (char) =>
                                            selectedChar.contains(char))) {
                                      showWinningDialog(context);
                                    }
                                    if (tries >= 6) {
                                      showLosingDialog(context);
                                    }
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
      ),
    );
  }
}

void showWinningDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          title: const Text('Congratulations!'),
          content: Text(
              'You have won the game.\n"${context.read<GameModelProvider>().guessWord}" is the right answer'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Go Home'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.5)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/homeScreen',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

void showLosingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          title: const Text('Game Over'),
          content: const Text('You have lost the game.'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.5)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/gameScreen',
                  (route) => false,
                );
              },
            ),
            ElevatedButton(
              child: const Text('Go Home'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.5)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/homeScreen',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget hiddenLetter(String char, bool visible, List<String> revealedLetters) {
  if (char == ' ') {
    return Text('   ');
  } else {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Visibility(
        visible:
            visible || revealedLetters.join('').toLowerCase().contains(char),
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
}

Widget buildHangMan(bool visible, String path) {
  return Visibility(
    visible: visible,
    child: Image.asset(path),
  );
}
