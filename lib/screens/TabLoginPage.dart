import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/data/CryptoManager.dart';
import 'package:warm_hearts_flutter/data/DataManager.dart';
import 'package:warm_hearts_flutter/data/user/UserModel.dart';
import 'package:warm_hearts_flutter/screens/BottomNavigationPage.dart';

class TabLoginPage extends StatefulWidget {
  final bool modeOverlay;
  const TabLoginPage({this.modeOverlay = false});
  @override
  _TabLoginPageState createState() => _TabLoginPageState();
}

class _TabLoginPageState extends State<TabLoginPage> {
  final CryptoManager _cryptoManager = CryptoManager();
  final DataManager _dataManager = DataManager();
  final FocusNode _eMailFocus = FocusNode();
  final FocusNode _passWordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CallManager _callManager = CallManager();
  int _loginMode = 0;
  int loginState = 0; /// 0-> idle 1-> validating
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
            gradient: SweepGradient(
                colors: [
                  Color(0xFFfc9842),
                  Color(0xFFfe5f75),
                ],
                center: AlignmentDirectional(1, -1),
                startAngle: 0,
                endAngle: 2.2,
                stops: [0.74, 1])),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
                      color: Color(0xFFF53803).withAlpha(100),
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
                                    child: Text('Giriş Yap'),
                                    style: TextStyle(color: _loginMode == 1 ? Colors.white : Color(0xFFFE5F75), fontWeight: FontWeight.w600, fontSize: _loginMode == 0 ? 15 : 12),
                                    duration: Duration(milliseconds: 200)),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    _loginMode = 0;
                                  });
                                },
                              ),
                              FlatButton(
                                child: AnimatedDefaultTextStyle(
                                    child: Text('Üye Ol'),
                                    style: TextStyle(color: _loginMode == 0 ? Colors.white : Color(0xFFFE5F75), fontWeight: FontWeight.w600, fontSize: _loginMode == 1 ? 15 : 12),
                                    duration: Duration(milliseconds: 200)),
                                onPressed: () {
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
                Spacer(),
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
                                activeColor: Color(0xFFFE5F75),
                                value: _rememberPassword,
                                onChanged: (bool state) {
                                  setState(() {
                                    _rememberPassword = state;
                                  });
                                },
                              ),
                            ),
                            Text('Beni hatırla')
                          ],
                        ),
                        SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
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
                              if (_loginMode == 0) {
                                _handleAuth();
                                return;
                              }
                              _handleSignUp();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              decoration: BoxDecoration(color: Color(0xFFfe5f75), borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: loginState == 0 ? Text(_loginMode == 0 ? 'Sign in' : 'Sign me up!', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)) :
                              SpinKitThreeBounce(
                                color: Colors.white,
                                duration: Duration(milliseconds: 500),
                                size: 20,
                              ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignUp() async {
    setState(() {
      loginState = 1;
    });
    UserModel userModel = await _callManager.signUp(email: _emailController.text.toString().trim(), password: _cryptoManager.encryptStringSha256(_passwordController.text.toString().trim()));
    if (userModel.success) {
      if(_rememberPassword){
        _dataManager.writeUser(userModel.user);
      }else{
        _dataManager.clearUser();
      }
      if(widget.modeOverlay){
        Navigator.of(context).pop();
      }else{
        Navigator.of(context).pushAndRemoveUntil(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft), (route) => false);
      }
    } else {
      Fluttertoast.showToast(msg: userModel.message);
    }
    setState(() {
      loginState = 0;
    });

  }

  void _handleAuth() async {
    setState(() {
      loginState = 1;
    });
    UserModel userModel = await _callManager.signIn(email: _emailController.text.toString().trim(), password: _cryptoManager.encryptStringSha256(_passwordController.text.toString().trim()));
    if (userModel.success) {
      if(_rememberPassword){
        _dataManager.writeUser(userModel.user);
      }else{
        _dataManager.clearUser();
      }
      if(widget.modeOverlay){
        Navigator.of(context).pop();
      }else{
        Navigator.of(context).pushAndRemoveUntil(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft), (route) => false);
      }
    } else {
      Fluttertoast.showToast(msg: userModel.message);
    }
    setState(() {
      loginState = 0;
    });
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
