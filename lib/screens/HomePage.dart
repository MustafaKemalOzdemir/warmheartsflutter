import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/screens/PostDetailPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CallManager _callManager = CallManager();
  int _pageCategoryMode = 0;

  /// 0-> All 1-> Adoption 2-> Missing 3->Mating

  Future<bool> _handleWillPop() async {
    return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.only(top: 15, right: 10, left: 10),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text('Are you sure to close Warm Hearts?', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600)),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Yes', style: TextStyle(color: Colors.grey[900])),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.grey[200],
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Text('No', style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    SizedBox(width: 5)
                  ],
                )) ??
        false;
  }

  void _onRefresh() async {
    _callManager.getMating().then((value) {
      if (value != null) {
        setState(() {
          StaticObjects.matingList = value;
        });
      }
    });
    _callManager.getMissing().then((value) {
      if (value != null) {
        setState(() {
          StaticObjects.missingList = value;
        });
      }
    });
    _callManager.getAdoption().then((value) {
      if (value != null) {
        setState(() {
          StaticObjects.adoptionList = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 1,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Home', style: TextStyle(color: Colors.white)),
          ),
          actions: <Widget>[
            Visibility(
              visible: false,
              child: Transform.rotate(
                angle: 5.6,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                _onRefresh();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageCategoryMode = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //color: _pageCategoryMode == 0 ? Color(0xFFfe5f75) : Colors.transparent,
                            color: _pageCategoryMode == 0 ? Color(0xFFfc9842) : Colors.transparent,
                          ),
                          child: AnimatedDefaultTextStyle(
                              child: Text('Tümü'),
                              style: TextStyle(color: _pageCategoryMode == 0 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 0 ? 15 : 14),
                              duration: Duration(milliseconds: 200)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageCategoryMode = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: _pageCategoryMode == 1 ? Color(0xFFfc9842) : Colors.transparent,
                          ),
                          child: AnimatedDefaultTextStyle(
                              child: Text('Sahiplendirme'),
                              style: TextStyle(color: _pageCategoryMode == 1 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 1 ? 15 : 14),
                              duration: Duration(milliseconds: 200)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageCategoryMode = 2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: _pageCategoryMode == 2 ? Color(0xFFfc9842) : Colors.transparent,
                          ),
                          child: AnimatedDefaultTextStyle(
                              child: Text('Kayıp'),
                              style: TextStyle(color: _pageCategoryMode == 2 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 2 ? 15 : 14),
                              duration: Duration(milliseconds: 200)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageCategoryMode = 3;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: _pageCategoryMode == 3 ? Color(0xFFfc9842) : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: AnimatedDefaultTextStyle(
                              child: Text('Çiftleştirme'),
                              style: TextStyle(color: _pageCategoryMode == 3 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 3 ? 15 : 14),
                              duration: Duration(milliseconds: 200)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - (40 + 3 * kToolbarHeight),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Visibility(
                      visible: _pageCategoryMode == 0 || _pageCategoryMode == 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: StaticObjects.adoptionList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 90,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xFFfc8803)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 80,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    _callManager.getImageUrl(StaticObjects.adoptionList[index].images.first),
                                                    fit: BoxFit.contain,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              Text(StaticObjects.adoptionList[index].title,
                                                  style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
                                              Spacer(),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Spacer(),
                                                  Text(
                                                    '${StaticObjects.adoptionList[index].town}/${StaticObjects.adoptionList[index].city}',
                                                    style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(width: 25)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(PageTransition(
                                        child: PostDetailPage(postMode: 0, preview: false, adoption: StaticObjects.adoptionList[index]), type: PageTransitionType.rightToLeft));
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: _pageCategoryMode == 0 || _pageCategoryMode == 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: StaticObjects.missingList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 90,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xFFfc4a03)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 80,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    _callManager.getImageUrl(StaticObjects.missingList[index].images.first),
                                                    fit: BoxFit.contain,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              Text(StaticObjects.missingList[index].title,
                                                  style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
                                              Spacer(),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Spacer(),
                                                  Text(
                                                    '${StaticObjects.missingList[index].town}/${StaticObjects.missingList[index].city}',
                                                    style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(width: 25)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        PageTransition(child: PostDetailPage(postMode: 1, preview: false, missing: StaticObjects.missingList[index]), type: PageTransitionType.rightToLeft));
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: _pageCategoryMode == 0 || _pageCategoryMode == 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: StaticObjects.matingList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 90,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xFFfce703)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 80,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    _callManager.getImageUrl(StaticObjects.matingList[index].images.first),
                                                    fit: BoxFit.contain,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 10),
                                              Text(StaticObjects.matingList[index].title,
                                                  style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
                                              Spacer(),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Spacer(),
                                                  Text(
                                                    '${StaticObjects.matingList[index].town}/${StaticObjects.matingList[index].city}',
                                                    style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(width: 25)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        PageTransition(child: PostDetailPage(postMode: 2, preview: false, mating: StaticObjects.matingList[index]), type: PageTransitionType.rightToLeft));
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
