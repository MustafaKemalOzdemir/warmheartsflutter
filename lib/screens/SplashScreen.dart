import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/data/DataManager.dart';
import 'package:warm_hearts_flutter/screens/BottomNavigationPage.dart';
import 'package:warm_hearts_flutter/screens/TabLoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CallManager _callManager = CallManager();
  DataManager _dataManager = DataManager();
  int _dataCount = 0;
  @override
  void initState() {
    super.initState();

    _callManager.getUsers().then((value){
      print('Users received');
    });

    _callManager.getCities().then((value){
      StaticObjects.cityList = value;
      _dataCount++;
    });

    //_callManager.getMissing();
    _callManager.getAnimalCategories().then((value){
      _dataCount++;
    });

    _callManager.getAdoption().then((value){
      if(value != null){
        StaticObjects.adoptionList = value;
      }
      _dataCount++;
    });

    _callManager.getMissing().then((value){
      if(value != null){
        StaticObjects.missingList = value;
      }
      _dataCount++;
    });

    _callManager.getMating().then((value){
      if(value != null){
        StaticObjects.matingList = value;
      }
      _dataCount++;
    });

    _dataManager.readUser().then((value){
      if(value != null){
        StaticObjects.userData = value;
        StaticObjects.accessToken = value.accessToken;
        StaticObjects.loginStatus = true;
      }
      _dataCount++;
    });
    dataCheck();
  }

  void dataCheck(){
    if(_dataCount == 6){
      Navigator.of(context).pushReplacement(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft));
    }else{
      Future.delayed(Duration(milliseconds: 100), (){
        dataCheck();
      });
    }
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
