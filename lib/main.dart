import 'package:flutter/material.dart';
import 'package:hangman/GameModelProvider.dart';
import 'package:hangman/GameScreen.dart';
import 'package:hangman/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => GameModelProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  HomeScreen(),
    );
  }
}


