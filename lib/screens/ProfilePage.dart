import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/screens/TabLoginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StaticObjects.loginStatus
          ? Center(
              child: Text('This is Profile Page'),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Icon(Icons.account_circle, color: Colors.blue, size: 140),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'My Profile',
                    style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text('Please login the system to access your profile', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                  SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: 35,
                    child: FlatButton(
                      color: Colors.blue,
                      child: Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(child: TabLoginPage(), type: PageTransitionType.rightToLeft));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
