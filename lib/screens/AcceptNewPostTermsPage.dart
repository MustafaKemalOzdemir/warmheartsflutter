import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/screens/CreateNewPostPage.dart';
import 'package:warm_hearts_flutter/screens/TabLoginPage.dart';

class AcceptNewPostTermsPage extends StatefulWidget {
  @override
  _AcceptNewPostTermsPageState createState() => _AcceptNewPostTermsPageState();
}

class _AcceptNewPostTermsPageState extends State<AcceptNewPostTermsPage> {
  bool _termsCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: StaticObjects.loginStatus ? Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Image.asset('images/fav_icon.png', fit: BoxFit.contain,),
              ),
            ),
            Text(
              'Warm Hearts',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 45, color: Colors.black),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[800],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                        child: Text('Şartlar ve Kurallar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 1,
                        color: Colors.grey[800],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Text(_termsText, style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 5, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Checkbox(
                      value: _termsCheckBox,
                      checkColor: Color(0xffffffff),
                      activeColor: Color(0xff0367BD),
                      onChanged: (state) {
                        setState(() {
                          _termsCheckBox = state;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text('Şartları ve Kuralları okudum ve kabul ediyorum', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 1
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xff0367BD),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text('İlan Paylaş', style: TextStyle(color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if(_termsCheckBox){
                    Navigator.of(context).push(PageTransition(child: CreateNewPostPage(), type: PageTransitionType.rightToLeft));
                  }else{
                    Fluttertoast.showToast(msg: 'Lütfen Şartlar ve Kuralları kabul edin');
                  }
                },
              ),
            ),
            SizedBox(height: kToolbarHeight + 10)
          ],
        ) : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 140,
                height: 140,
                child: Icon(Icons.add_circle, color: Color(0xFF0367BD), size: 140),
              ),
              SizedBox(height: 20),
              Text(
                'İlan oluştur',
                style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('İlan paylaşabimek için sisteme giriş yapmanız gerekmektedir', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.65,
                height: 35,
                child: FlatButton(
                  color: Color(0xFF0367BD),
                  child: Text('Griş Yap', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(child: TabLoginPage(modeOverlay: true), type: PageTransitionType.rightToLeft)).then((value){
                      setState(() {

                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }

  String _termsText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non aliquam nisi, eget fermentum tellus. Nullam faucibus, orci ullamcorper auctor ultricies, sapien eros posuere magna, a iaculis enim tellus a tortor. Sed egestas vel nibh nec faucibus. Nulla tincidunt imperdiet consequat. Nulla facilisi. Fusce eget elit quis dolor aliquam ultrices at ut dolor. Curabitur vulputate vel orci vitae gravida. Vestibulum arcu quam, varius et tempor in, tristique sit amet nibh.Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed mi mauris, lacinia ac dignissim in, semper non lectus. In ullamcorper eros sodales blandit pharetra. Morbi rhoncus lobortis mi non varius. Praesent at sagittis arcu, in iaculis libero. Phasellus auctor ipsum eu justo sodales molestie. Suspendisse dignissim, augue nec tincidunt viverra, massa lectus laoreet sem, vitae scelerisque mi urna in justo. Proin a est iaculis, luctus tortor non, dapibus ligula. Suspendisse ultrices, ipsum a varius maximus, odio tellus molestie risus, a gravida metus ligula non orci.Duis suscipit, odio id tincidunt rutrum, lacus sem scelerisque lacus, at mattis libero nulla vitae justo. Etiam venenatis dolor enim. Curabitur quis dui nec neque laoreet bibendum rutrum sit amet mi. Ut vestibulum sapien sed ante cursus, quis consectetur arcu eleifend. Curabitur aliquet ligula id posuere porta. Sed aliquet orci in ante vestibulum, sit amet porttitor dolor ullamcorper. Integer nec nibh in neque rutrum accumsan. Morbi vulputate massa ex, id aliquam velit semper non. Aliquam mattis arcu ut libero tempor, sit amet euismod turpis dapibus. Phasellus diam ex, tempor congue sodales eu, fringilla ut orci. Ut hendrerit, ante a viverra porta, nulla augue interdum risus, at iaculis tortor orci id ipsum. Fusce quis laoreet elit, a suscipit velit. Sed ipsum justo, lacinia at dignissim vitae, accumsan nec sem. Quisque eget varius leo, eu iaculis quam. Quisque sodales lectus at nulla.';
}
