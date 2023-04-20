import 'package:flutter/material.dart';
import 'package:hangman/HomeScreen.dart';
import 'package:hangman/intro_screens/intro_page_1.dart';
import 'package:hangman/intro_screens/intro_page_3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_screens/intro_page_2.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _pageController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index){
              if(index == 2){
                setState(() {
                  onLastPage = true;
                });
              }else{
                setState(() {
                  onLastPage = false;
                });
              }
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3()
            ],
          ),
          Container(
              alignment: Alignment(0,0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: Text('Skip', style: TextStyle(
                        fontSize: 20
                      ),),
                  onTap: (){
                    _pageController.jumpToPage(2);
                  }),
                  SmoothPageIndicator(controller: _pageController, count: 3),
                  onLastPage ? GestureDetector(
                      onTap: () async {
                        final pref = await SharedPreferences.getInstance();
                        pref.setBool('showHome', true);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: Text('Done', style: TextStyle(
                        fontSize: 20
                      ),)) : GestureDetector(
                    onTap: (){
                      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                    },
                      child: Text('Next', style: TextStyle(
                        fontSize: 20
                      ),))
                ],
              )),
        ],
      ),
    );
  }
}
