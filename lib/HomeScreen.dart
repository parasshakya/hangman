import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hangman/ChooseLettersScreen.dart';
import 'package:provider/provider.dart';
import 'package:hangman/GameModelProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _guessWordController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _hintFocusNode = FocusNode(); // Create a FocusNode for the hint TextField

  void _onGuessWordSubmitted() {
    // When the guess word is submitted, move the focus to the hint TextField
    FocusScope.of(context).requestFocus(_hintFocusNode);
  }

  void _onHintSubmitted() {
    // When the hint is submitted, start the game
    if (_formKey.currentState!.validate()) {
      _startGame(context);
    }
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
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }


  void _startGame(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    // Get the current values of the guess word and hint from the text fields
    final String guessWord = _guessWordController.text.trim();
    final String hint = _hintController.text.trim();

    // Update the values in the GameModel using the provider package
    final  gameModelProvider = context.read<GameModelProvider>();
    gameModelProvider.setHint(hint);
    gameModelProvider.setGuessWord(guessWord);

    // Navigate to the game screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseLetterScreen()),
    );
    setState(() {
      isLoading = false;
    });

  }



  @override
  void dispose() {
    _guessWordController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hangman'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 150,
                    child: Image.asset('assets/images/hangmanImage.png', color: Colors.white,)),
                const SizedBox(height: 40.0),
                const Text(
                  'Enter a word for your opponent to guess:',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  validator: (val){
                    if(val!.isEmpty ){
                      return 'Please enter a guess word';
                    }
                    if(val.replaceAll(' ', '').length > 30){
                      return 'Guess Word should be less than 30 letters';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(val.replaceAll(RegExp(r'\s+'), ''))) {
                      return "Guess word should contain only letters";
                    }

                    else{
                      return null;
                    }
                  },
                  controller: _guessWordController,
                  onFieldSubmitted: (_) => _onGuessWordSubmitted(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'e.g. banana',
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Enter a hint to help your opponent:',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  focusNode: _hintFocusNode,
                  onFieldSubmitted: (_) => _onHintSubmitted(),
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Please enter a hint';
                    }
                    if(val.replaceAll(' ', '').length > 70){
                      return 'Hint should be less than 70 letters';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(val.replaceAll(RegExp(r'\s+'), ''))) {
                      return "Hint should contain only letters";
                    }
                    else{
                      return null;
                    }
                  },
                  controller: _hintController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'e.g. a yellow fruit',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _startGame(context);
                      }
                  },
                  child: isLoading ? const Center(child: CircularProgressIndicator(),) : const Text('Start Game'),
                ),
                const SizedBox(height: 100,),
                const Text('Contact Developer', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.instagram),
                      onPressed: () {
                        launchUrlString('https://www.instagram.com/lllparaslll/');
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onPressed: () {
                        launchUrlString('https://github.com/parasshakya/hangman');
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {
                        launchUrlString('https://www.facebook.com/parazjaggedup.shakya');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
