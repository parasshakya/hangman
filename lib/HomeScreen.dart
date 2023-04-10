import 'package:flutter/material.dart';
import 'package:hangman/ChooseLettersScreen.dart';
import 'package:provider/provider.dart';
import 'package:hangman/GameModelProvider.dart';


class HintPage extends StatefulWidget {
  @override
  _HintPageState createState() => _HintPageState();
}

class _HintPageState extends State<HintPage> {
  final TextEditingController _guessWordController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _startGame(BuildContext context) {
    // Get the current values of the guess word and hint from the text fields
    final String guessWord = _guessWordController.text;
    final String hint = _hintController.text;

    // Update the values in the GameModel using the provider package
    final  gameModelProvider = context.read<GameModelProvider>();
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
        title: const Text('Hangman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter a word for your opponent to guess:',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                validator: (val){
                  if(val!.isEmpty ){
                    return 'Please enter the guess word';
                  }
                  if(val.length > 12){
                    return "Guess word should be less than 13 letters";
                  }
                  else{
                    return null;
                  }
                },
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
              TextFormField(
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter a hint';
                  }
                  if(val.length > 15){
                    return 'Hint should be less than 15 letters';
                  }
                  else{
                    return null;
                  }
                },
                controller: _hintController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'e.g. A cross-platform mobile development framework',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _startGame(context);
                    }
                },
                child: const Text('Start Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
