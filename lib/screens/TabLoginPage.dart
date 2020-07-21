import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/screens/BottomNavigationPage.dart';

class TabLoginPage extends StatefulWidget {
  @override
  _TabLoginPageState createState() => _TabLoginPageState();
}

class _TabLoginPageState extends State<TabLoginPage> {
  final FocusNode _eMailFocus = FocusNode();
  final FocusNode _passWordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _loginMode = 0;
  bool _hiddenPassword = true;
  bool _autoValidate = false;
  String emailText;
  String passwordText;
  bool _rememberPassword = false;
  String emailErrorText = '';
  String passwordErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text('Login Warm Hearts', style: TextStyle(color: Colors.grey[800])),
      ),
      */
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.lightBlue[300],
              Colors.blue[400]
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.3, 0.6,1
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset('images/fav_icon.png'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              Center(
                child: Text(
                  'Warm Hearts',
                  style: TextStyle(fontFamily: 'Pacifico', fontSize: 45, color: Colors.black),
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
                                  child: Text('Sign Up'),
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
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'E-Mail',
                          style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        height: 40,
                        child: TextFormField(
                          style: TextStyle(fontSize: 17, color: Colors.grey[800]),
                          obscureText: false,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: _eMailFocus,
                          controller: _emailController,
                          cursorColor: Colors.blueGrey,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, left: 6),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.4, color: Color(0x33000000)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.4, color: Color(0x33000000)),
                            ),
                          ),
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _eMailFocus, _passWordFocus);
                          },
                          onChanged: (String text) {
                            if (_autoValidate) {
                              _validateEmail(text);
                            }
                          },
                        ),
                      ),
                      Visibility(
                          visible: emailErrorText.length != 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, bottom: 1, top: 5),
                            child: Text(emailErrorText, style: TextStyle(color: Colors.red)),
                          )),
                      SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          'Password',
                          style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        height: 40,
                        child: TextFormField(
                          style: TextStyle(fontSize: 17, color: Colors.grey[800]),
                          obscureText: _hiddenPassword,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.blueGrey,
                          decoration: InputDecoration(
                            suffixIcon: getSuffixIcon(),
                            contentPadding: EdgeInsets.only(top: 10, left: 6),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.4, color: Color(0x33000000)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.4, color: Color(0x33000000)),
                            ),
                          ),
                          maxLines: 1,
                          focusNode: _passWordFocus,
                          controller: _passwordController,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          onChanged: (String text) {
                            if (_autoValidate) {
                              _validatePassword(text);
                            }
                          },
                        ),
                      ),
                      Visibility(
                          visible: passwordErrorText.length != 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, bottom: 1, top: 5),
                            child: Text(passwordErrorText, style: TextStyle(color: Colors.red)),
                          )),
                      SizedBox(height: 2),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 35,
                            height: 30,
                            child: Checkbox(
                              activeColor: Colors.lightBlue,
                              value: _rememberPassword,
                              onChanged: (bool state) {
                                setState(() {
                                  _rememberPassword = state;
                                });
                              },
                            ),
                          ),
                          Text('Remember me')
                        ],
                      ),
                      SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: (){
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              _autoValidate = true;
                            });
                            bool email = _validateEmail(_emailController.text.toString());
                            bool pass = _validatePassword(_passwordController.text.toString());
                            if (!email || !pass) {
                              print('returned');
                              return;
                            }
                            if(_loginMode == 0){
                              _handleAuth();
                              return;
                            }
                            _handleSignUp();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(child: Text(_loginMode == 0 ? 'Sign in' : 'Sign me up!', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp(){
    //todo signup codes here
  }

  void _handleAuth() {
    //todo sign in codes here
    if (_emailController.text.toLowerCase() == 'u@m.c' && _passwordController.text.toLowerCase() == '123456') {
        Navigator.of(context).push(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft));
    } else {
      Fluttertoast.showToast(msg: 'Check E-Mail and Password', toastLength: Toast.LENGTH_SHORT);
    }
  }


  bool _validateEmail(String text) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
    if (emailValid && text.length < 35) {
      setState(() {
        emailErrorText = '';
      });
      return true;
    } else {
      setState(() {
        emailErrorText = 'Please enter valid E-Mail!';
      });
      return false;
    }
  }

  bool _validatePassword(String text) {
    if (text.length == 0) {
      setState(() {
        passwordErrorText = 'Password field can\'t be empty!';
      });
      return false;
    }
    if (text.length < 6 || text.length > 18) {
      setState(() {
        passwordErrorText = 'Password length must be between 6-18!';
        return;
      });
      return false;
    }
    setState(() {
      passwordErrorText = '';
    });
    return true;
  }

  Widget getSuffixIcon() {
    return IconButton(
      icon: Icon(
        _hiddenPassword ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey[500],
      ),
      onPressed: () {
        setState(() {
          _hiddenPassword = !_hiddenPassword;
        });
      },
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
