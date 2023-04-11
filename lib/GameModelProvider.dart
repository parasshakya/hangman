import 'package:flutter/material.dart';


class GameModelProvider extends ChangeNotifier {
  late String _guessWord;
  late String _hint;
  late List<int> _revealedIndices;

  String get guessWord => _guessWord;
  String get hint => _hint;
  List<int> get revealedIndices => _revealedIndices;

  void setGuessWord(String guessWord) {
    _guessWord = guessWord;
    notifyListeners();
  }

  void setHint(String hint) {
    _hint = hint;
    notifyListeners();
  }

  void setRevealedIndices(List<int> revealedIndices) {
    _revealedIndices = revealedIndices;
    notifyListeners();
  }

  void removeRevealedIndices(int index){
    _revealedIndices.remove(index);
    notifyListeners();

  }
}