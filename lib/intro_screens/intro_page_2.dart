import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      padding: EdgeInsets.all(10),
      child: Center(
          child: Text(
              'Basic Rules:\n1. There are two players.\n2. Player 1 enters a hint and a word.\n3. Player 1 chooses the letters to be shown to Player 2.\n4. Player 1 passes the phone to Player 2.\n5. Player 2 tries to guess the correct word with the help of the hint.',
              style: GoogleFonts.raleway(
                  fontSize: 25, fontWeight: FontWeight.w600),
          textAlign: TextAlign.start,),
      ),
    );
  }
}
