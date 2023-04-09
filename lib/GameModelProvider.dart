import 'package:flutter/material.dart';

import 'constants.dart';

class GameModelProvider extends ChangeNotifier {
  late String _guessWord;
  late String _hint;
  late List<String> _revealedLetters;

  String get guessWord => _guessWord;
  String get hint => _hint;
  List<String> get revealedLetters => _revealedLetters;

  void setGuessWord(String guessWord) {
    _guessWord = guessWord;
    notifyListeners();
  }

  void setHint(String hint) {
    _hint = hint;
    notifyListeners();
  }

  void setRevealedLetters(List<String> revealedLetters) {
    _revealedLetters = revealedLetters;
    notifyListeners();
  }

  void removeRevealedLetters(String letter){
    _revealedLetters.remove(letter);
    notifyListeners();

  }
}