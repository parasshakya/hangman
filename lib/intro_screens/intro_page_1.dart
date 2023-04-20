import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pinkAccent,
      padding: EdgeInsets.all(10),
      child: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome To Hangman', style: GoogleFonts.raleway(
                fontSize: 30,
                fontWeight: FontWeight.w600
            ),
              textAlign: TextAlign.center,),
            SizedBox(
                height: 500,
                width: double.infinity,
                child: Image.asset("assets/images/sketch1.png", fit: BoxFit.cover,)),
          ],
        )
      ),
    );
  }
}
