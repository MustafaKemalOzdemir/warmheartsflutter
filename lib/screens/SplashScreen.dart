import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/screens/BottomNavigationPage.dart';

class SplashScreen extends StatelessWidget {
  static BuildContext myContext;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), (){
      Navigator.of(myContext).push(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft));
    });

    return MaterialApp(
      home: Builder(builder: (newContext) {
        myContext = newContext;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(newContext).size.width / 8),
                  child: Container(child: Image.asset('images/fav_icon.png')),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
