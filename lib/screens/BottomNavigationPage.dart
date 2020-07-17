import 'package:flutter/material.dart';
import 'package:warm_hearts_flutter/screens/AddPostPage.dart';
import 'package:warm_hearts_flutter/screens/HomePage.dart';
import 'package:warm_hearts_flutter/screens/NearbyMapPage.dart';
import 'package:warm_hearts_flutter/screens/ProfilePage.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _pageMode = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _pageMode,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), title: Text('Nearby')),
          BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('Add Post')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
        onTap: (state){
          setState(() {
            _pageMode = state;
          });
        },
      ),
    );
  }

  Widget _getBody(){
    switch(_pageMode){
      case 0: return HomePage();
      case 1: return NearbyMapPage();
      case 2: return AddPostPage();
      case 3: return ProfilePage();
      default: return Center(child: Text('Error on Navigation'));
    }
  }
}
