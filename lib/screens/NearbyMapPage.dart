import 'package:flutter/material.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';

class NearbyMapPage extends StatefulWidget {
  @override
  _NearbyMapPageState createState() => _NearbyMapPageState();
}

class _NearbyMapPageState extends State<NearbyMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('This is NearbyMap Page'),
          onPressed: (){
            StaticObjects.loginStatus = false;
          },
        ),
      ),
    );
  }
}
