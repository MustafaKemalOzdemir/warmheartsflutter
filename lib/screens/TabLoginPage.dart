import 'package:flutter/material.dart';

class TabLoginPage extends StatefulWidget {
  @override
  _TabLoginPageState createState() => _TabLoginPageState();
}

class _TabLoginPageState extends State<TabLoginPage> {
  int _loginMode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Warm Hearts', style: TextStyle(color: Colors.grey[800])),
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image.asset('images/fav_icon.png'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Center(
              child: Text(
                'Warm Hearts',
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 45),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.lightBlue,
                ),
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: _loginMode == 0 ? 3 : (MediaQuery.of(context).size.width * 0.25) - 3,
                      top: 3,
                      bottom: 3,
                      right: _loginMode == 0 ? (MediaQuery.of(context).size.width * 0.25) - 3 : 3,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                            child: AnimatedDefaultTextStyle(
                                child: Text('Sign In'),
                                style: TextStyle(color: _loginMode == 1 ? Colors.white : Colors.blue, fontWeight: FontWeight.w600, fontSize: _loginMode == 0 ? 15 : 12),
                                duration: Duration(milliseconds: 200)
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                _loginMode = 0;
                              });
                            },
                          ),
                          FlatButton(
                            child:  AnimatedDefaultTextStyle(
                                child: Text('Sign In'),
                                style: TextStyle(color: _loginMode == 0 ? Colors.white : Colors.blue, fontWeight: FontWeight.w600, fontSize: _loginMode == 1 ? 15 : 12),
                                duration: Duration(milliseconds: 200)
                            ),
                            onPressed: (){
                              setState(() {
                                _loginMode = 1;
                              });
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
