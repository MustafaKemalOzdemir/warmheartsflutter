import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Transform.rotate(
              angle: 5.6,
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white,),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10),
            SingleChildScrollView(
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
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: _pageCategoryMode == 0 ? Colors.blue : Colors.transparent,
                        ),
                        child: AnimatedDefaultTextStyle(
                            child: Text('All'),
                            style:
                                TextStyle(color: _pageCategoryMode == 0 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 0 ? 15 : 14),
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
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: _pageCategoryMode == 1 ? Colors.blue : Colors.transparent,
                        ),
                        child: AnimatedDefaultTextStyle(
                            child: Text('Adoption'),
                            style:
                                TextStyle(color: _pageCategoryMode == 1 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 1 ? 15 : 14),
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
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: _pageCategoryMode == 2 ? Colors.blue : Colors.transparent,
                        ),
                        child: AnimatedDefaultTextStyle(
                            child: Text('Missing'),
                            style:
                                TextStyle(color: _pageCategoryMode == 2 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 2 ? 15 : 14),
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
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          color: _pageCategoryMode == 3 ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: AnimatedDefaultTextStyle(
                            child: Text('Mating'),
                            style:
                                TextStyle(color: _pageCategoryMode == 3 ? Colors.white : Colors.grey[800], fontWeight: FontWeight.w600, fontSize: _pageCategoryMode == 3 ? 15 : 14),
                            duration: Duration(milliseconds: 200)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
