import 'package:flutter/material.dart';
import 'package:warm_hearts_flutter/screens/HomePage.dart';
import 'package:warm_hearts_flutter/screens/NearbyMapPage.dart';
import 'package:warm_hearts_flutter/screens/ProfilePage.dart';
import 'package:warm_hearts_flutter/screens/AcceptNewPostTermsPage.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _pageMode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: SweepGradient(
                colors: [
                  Color(0xFFfc9842),
                  Color(0xFFfe5f75),
                ],
                center: AlignmentDirectional(1, -1),
                startAngle: 0,
                endAngle: 2.2,
                stops: [0.74, 1])),
        child: _getBody(),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xff0367BD),
          currentIndex: _pageMode,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text('Nearby')),
            BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('Add Post')),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile')),
          ],
          onTap: (state) {
            setState(() {
              _pageMode = state;
            });
          },
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_pageMode) {
      case 0:
        return HomePage();
      case 1:
        return NearbyMapPage();
      case 2:
        return AcceptNewPostTermsPage();
      case 3:
        return ProfilePage();
      default:
        return Center(child: Text('Error on Navigation'));
    }
  }
}
