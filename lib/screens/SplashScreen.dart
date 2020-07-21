import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/screens/TabLoginPage.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), (){
      //Navigator.of(myContext).push(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft));
      Navigator.of(context).pushReplacement(PageTransition(child: TabLoginPage(), type: PageTransitionType.rightToLeft));
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          actionsIconTheme: IconThemeData(
            color: Colors.grey[800],
          ),
        )
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                child: Container(child: Image.asset('images/fav_icon.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
