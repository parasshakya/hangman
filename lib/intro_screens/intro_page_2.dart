import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Text(
                  'How To Play',
                  style: TextStyle(
                      fontSize: 40,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.dashed),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Image.asset("assets/images/howToPlaySketch.png")),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Here is a list of detailed instructions on how to play this game:\n\n1. The game is played with at least two players.\n\n2. Player 1 chooses a word or phrase to be guessed and a hint describing that word or phrase without showing other player(s).\n\n3. Then Player 1 has to choose which letters to show to other player(s). Tapping a letter will select all the instances of that letter. The player cannot select all the letters and the player must select at least one letter to show.\n\n5. Now, player 1 hands over the phone to other player(s).\n\n6. Then, the other player(s) try to guess the word with the help of the hint that is displayed on the screen.\n\n7. Guessing a wrong letter will draw a part of hangman and once all the 7 parts are drawn, the player trying to guess the word loses.\n\n8. When the player guesses all the letters of the word correctly before the hangman is drawn, the player wins.\n\n9. Players can switch roles and play another round.',
                      style: GoogleFonts.raleway(
                          fontSize: 11, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.justify,),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
