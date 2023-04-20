import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.purpleAccent,
      child: Center(
          child : Text('Made With Love ❤️ \n\n By \n\n Paras Shakya', style: GoogleFonts.raleway(
              fontSize: 30,
              fontWeight: FontWeight.w600
          ),
          textAlign: TextAlign.center,)
      ),
    );
  }
}
