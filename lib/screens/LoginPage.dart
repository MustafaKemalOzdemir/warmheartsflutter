import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:warm_hearts_flutter/custom_widgets/PasswordResetDialog.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/data/user/UserModel.dart';

class LoginPage extends StatefulWidget {
  final middleWare;
  const LoginPage({this.middleWare = false});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _eMailFocus = FocusNode();
  final FocusNode _passWordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CallManager _callManager = CallManager();

  int _pageMode = 0; ///0 login - 1 signUp
  int loginState = 0; ///0 idle - 1 on login - 2 on signUp
  bool _hiddenPassword = true;
  bool _autoValidate = false;
  bool _campaignPermission = false;
  String _buttonTitle = 'Giriş Yap';
  String emailErrorText = '';
  String passwordErrorText = '';
  double loginButtonWidth;
  String _genderSelection;


  @override
  Widget build(BuildContext context) {
    if(loginButtonWidth != 50){
      loginButtonWidth = MediaQuery.of(context).size.width - 80;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFf8f8f8),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 40) / 2,
                          height: 60,
                          decoration: BoxDecoration(
                              color: _pageMode == 0 ? Colors.white : Colors.grey[200],
                              border: Border(
                                  left: BorderSide(width: 1, color: Colors.grey[300]),
                                  top: BorderSide(width: 1, color: Colors.grey[300]),
                                  bottom: BorderSide(width: 1, color: Colors.grey[300]),
                                  right: BorderSide(width: 0.5, color: Colors.grey[300]))),
                          child: Center(
                            child: Text(
                              'Üye Girişi',
                              style: TextStyle(color: _pageMode == 0 ? Color(0xFFff6000) : Colors.grey[700], fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        onTap: (){
                          _handlePageModeChange(1, 0);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 20) / 2,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _pageMode == 1 ? Colors.white : Colors.grey[200],
                            border: Border(
                              left: BorderSide(width: 0.5, color: Colors.grey[300]),
                              top: BorderSide(width: 1, color: Colors.grey[300]),
                              bottom: BorderSide(width: 1, color: Colors.grey[300]),
                              right: BorderSide(width: 1, color: Colors.grey[300]),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Üye Ol',
                              style: TextStyle(color: _pageMode == 1 ? Color(0xFFff6000) : Colors.grey[700], fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        onTap: (){
                          print('pageMode: $_pageMode');
                          _handlePageModeChange(0, 1);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              left: BorderSide(width: 1, color: Colors.grey[300]),
                              right: BorderSide(width: 1, color: Colors.grey[300]),
                              bottom: BorderSide(width: 1, color: Colors.grey[300]),
                            )
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('E-Posta Adresi', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(height: 3),
                            Container(
                              height: 40,
                              child: CupertinoTextField(
                                style: TextStyle(fontSize: 17, color: Colors.grey[800]),
                                padding: EdgeInsets.only(top: 10, left: 6),
                                obscureText: false,
                                maxLines: 1,
                                focusNode: _eMailFocus,
                                controller: _emailController,
                                onSubmitted: (term){
                                  _fieldFocusChange(context, _eMailFocus, _passWordFocus);
                                },
                                onChanged: (String text){
                                  if(_autoValidate){
                                    _validateEmail(text);
                                  }
                                },
                              ),
                            ),
                            Visibility(
                                visible: emailErrorText.length != 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0, bottom: 5, top: 5),
                                  child: Text(emailErrorText, style: TextStyle(color: Colors.red)),
                                )
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('Şifre', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(height: 3),
                            Container(
                              height: 40,
                              child: CupertinoTextField(
                                style: TextStyle(fontSize: 17, color: Colors.grey[800]),
                                obscureText: _hiddenPassword,
                                suffix: getSuffixIcon(),
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                focusNode: _passWordFocus,
                                controller: _passwordController,
                                onSubmitted: (term){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                onChanged: (String text){
                                  if(_autoValidate){
                                    _validatePassword(text);
                                  }
                                },
                              ),
                            ),
                            Visibility(
                                visible: passwordErrorText.length != 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0, bottom: 5, top: 5),
                                  child: Text(passwordErrorText, style: TextStyle(color: Colors.red)),
                                )
                            ),
                            SizedBox(height: 10),
                            Visibility(
                              visible: _pageMode == 0,
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text('Şifremi Unuttum', style: TextStyle(color: Colors.blue)),
                                ),
                                onTap: (){
                                  _resetDialogBox();
                                },
                              ),
                            ),
                            Visibility(
                              visible: _pageMode == 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Cinsiyet', style: TextStyle(color: Colors.grey[500])),
                                    value: _genderSelection,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Kadın'),
                                        value: 'Kadın',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Erkek'),
                                        value: 'Erkek',
                                      )
                                    ],
                                    onChanged: (value) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      setState(() {
                                        _passWordFocus.unfocus();
                                        _genderSelection = value;
                                      });
                                      print('value $value');
                                    },
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Checkbox(
                                              value: _campaignPermission,
                                              checkColor: Colors.white,
                                              activeColor: Color(0xFFff6000),
                                              onChanged: (value) {
                                                setState(() {
                                                  _campaignPermission = value;
                                                });
                                              }),
                                          Expanded(
                                            child: RichText(
                                              maxLines: 4,
                                              softWrap: true,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: 'Kampanyalar',
                                                  style: TextStyle(color: Color(0xFFff6000), decoration: TextDecoration.underline),
                                                ),
                                                TextSpan(
                                                  text: ' ile ilgili e-posta almak istiyorum.',
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Center(
                              child: GestureDetector(
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.decelerate,
                                  child: loginState == 0
                                      ? Center(
                                      child: Text(
                                        _buttonTitle,
                                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                                      ))
                                      : Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 0),
                                        child: JumpingDotsProgressIndicator(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: Color(0xFFff6000),
                                  ),
                                  width: loginButtonWidth,
                                  height: 40,
                                ),
                                onTap: () {
                                  if(loginState == 1){
                                    return;
                                  }
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                  bool email = _validateEmail(_emailController.text.toString());
                                  bool pass = _validatePassword(_passwordController.text.toString());
                                  if(!email || !pass){
                                    print('returned');
                                    return;
                                  }

                                  setState(() {
                                    loginState = 1;
                                    loginButtonWidth = 50;
                                  });
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if (_pageMode == 0) {
                                    _handleAuth();
                                  } else {
                                    _handleSignUp();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        visible: widget.middleWare,
                        child: GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 30 / 2,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[300],
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 15),
                                Text('Üye Olmadan Devam Et', maxLines: 1, softWrap: true, overflow: TextOverflow.fade, style: TextStyle(color: Color(0xFFff6000), fontSize: 16, fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios, color: Color(0xFFff6000), size: 20,),
                                SizedBox(width: 10)
                              ],
                            ),
                          ),
                          onTap: (){
                            //Navigator.of(context).push(PageTransition(child: AddAddressPage(middleWare: true, basketData: widget.basketData), type: PageTransitionType.rightToLeft));
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _resetDialogBox() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PasswordResetDialog(
          context: context,
          sendPressed: (String email, BuildContext dialogContext) {
            print(email);
            /*
            _callManager.memberPasswordReset(email).then((data) {
              Fluttertoast.showToast(msg: data, toastLength: Toast.LENGTH_LONG);
              Navigator.of(dialogContext).pop();
            });

            */

          },
        );
      },
    );
  }


  void _handleAuth() async{
    if (_emailController.text.toString() == null || _passwordController.text.toString() == null) {
      Fluttertoast.showToast(msg: 'Şuan Sunucularımız Meşgul');
      setState(() {
        loginState = 0;
        loginButtonWidth = MediaQuery.of(context).size.width - 80;
      });
      return;
    }

    UserModel userModel = await _callManager.signIn(email: _emailController.text.toString(), password: _passwordController.text.toString());
    if(userModel.success){
      setState(() {
        loginState = 0;
        loginButtonWidth = MediaQuery.of(context).size.width - 80;
      });
      print('Başarılı');
    }else{
      setState(() {
        loginState = 0;
        loginButtonWidth = MediaQuery.of(context).size.width - 80;
      });
      print(userModel.message);
    }

  }

  void _handleSignUp(){

  }

  bool _validateEmail(String text){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
    if (emailValid && text.length < 35) {
      setState(() {
        emailErrorText = '';
      });
      return true;
    } else {
      setState(() {
        emailErrorText = 'Lütfen Geçerli E-Posta Adresi Girin!';
      });
      return false;
    }
  }

  bool _validatePassword(String text){
    if(text.length == 0){
      setState(() {
        passwordErrorText = 'Şifre Alanı Boş Olamaz';
      });
      return false;
    }
    if(text.length < 6 || text.length > 18){
      setState(() {
        passwordErrorText = 'Şifreniz 6-18 karakter aralığında olmalıdır';
        return;
      });
      return false;
    }
    setState(() {
      passwordErrorText = '';
    });
    return true;
  }

  Widget getSuffixIcon(){
    return IconButton(
      icon: Icon(_hiddenPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey[500],),
      onPressed: () {
        setState(() {
          _hiddenPassword = !_hiddenPassword;
        });
      },
    );
  }

  void _handlePageModeChange(int oldValue, int newValue) {
    if (_pageMode == oldValue) {
      setState(() {
        _pageMode = newValue;
        _genderSelection = null;
        newValue == 1 ? _buttonTitle = 'Üye Ol' : _buttonTitle = 'Giriş Yap';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}
