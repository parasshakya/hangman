import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman/ChooseLettersScreen.dart';
import 'package:hangman/GameModelProvider.dart';
import 'package:hangman/GameScreen.dart';
import 'package:hangman/HomeScreen.dart';
import 'package:hangman/OnBoardingScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



bool showHome = false;

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
   final pref = await SharedPreferences.getInstance();
   showHome = pref.getBool('showHome') ?? false;
  runApp(ChangeNotifierProvider(
    create: (_) => GameModelProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      routes: {
        '/homeScreen': (context) => HomeScreen(),
        '/chooseLettersScreen': (context) => ChooseLetterScreen(),
        '/gameScreen': (context) => GameScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  showHome ? HomeScreen() : OnBoardingScreen(),
    );
  }
}


