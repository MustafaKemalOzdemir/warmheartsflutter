import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/Constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/screens/LoginPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageState = 0;
  CallManager _callManager = CallManager();

  @override
  void initState() {
    super.initState();
    _callManager.getPosts();
  }

  /// 0 -> Home / 1 -> Store / 2-> Chat / 3-> profile
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: (){
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.redAccent,
          elevation: 2,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.home, color: _pageState == StaticObjects.PAGE_MODE_HOME ? Colors.blueAccent : Colors.white),
                  onPressed: () {
                    _handlePageStateChange(StaticObjects.PAGE_MODE_HOME);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: _pageState == StaticObjects.PAGE_MODE_STORE ? Colors.blue : Colors.grey),
                  onPressed: () {
                    _handlePageStateChange(StaticObjects.PAGE_MODE_STORE);
                  },
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  height: 5,
                ),
              ),

              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.chat, color: _pageState == StaticObjects.PAGE_MODE_CHAT ? Colors.blueAccent : Colors.grey),
                  onPressed: () {
                    _handlePageStateChange(StaticObjects.PAGE_MODE_CHAT);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.account_box, color: _pageState == StaticObjects.PAGE_MODE_ACCOUNT ? Colors.blueAccent : Colors.grey),
                  onPressed: () {
                    _handlePageStateChange(StaticObjects.PAGE_MODE_ACCOUNT);
                    Navigator.of(context).push(PageTransition(child: LoginPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 200)));
                  },
                ),
              ),
            ],
          ),
        ),
        body: _getBody(),
      ),
    );
  }

  _handlePageStateChange(int newState) {
    if (newState != _pageState) {
      setState(() {
        _pageState = newState;
      });
    }
  }

  Widget _getBody(){
    if(_pageState == StaticObjects.PAGE_MODE_ACCOUNT){
      return LoginPage();
    }else{
      return Center(
        child: Text(_pageState.toString()),
      );
    }
  }
}
