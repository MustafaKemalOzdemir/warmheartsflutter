import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/custom_widgets/AnimalDetailListTile.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/data/post/Adoption.dart';
import 'package:warm_hearts_flutter/data/post/Mating.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
import 'package:warm_hearts_flutter/data/user/User.dart';
import 'package:warm_hearts_flutter/screens/BottomNavigationPage.dart';
import 'package:warm_hearts_flutter/screens/ImageDetailScreen.dart';

class PostDetailPage extends StatefulWidget {
  final List<File> imageList;
  final Adoption adoption;
  final Mating mating;
  final Missing missing;
  final int postMode;
  final bool preview;

  const PostDetailPage({@required this.postMode, this.adoption, this.mating, this.missing, this.imageList, this.preview = false});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  CallManager _callManager = CallManager();
  List<String> _imageList = List();
  List<Marker> _markers = <Marker>[];
  User _user;
  bool _userDone = false;
  int carouselIndex = 0;
  String _postTitle;
  String _postDescription;
  String _postId;
  String _date;
  String _dateInFormat;

  //animal info
  String _animalName;
  String _type;
  String _race;
  String _gender;
  String _age;
  String _source;
  int _regularVaccine = -1;
  int _castrated = -1;

  //address info
  String _city;
  String _town;
  String _addressDetail;
  LatLng _selectedPosition;

  //missing
  int _collar = -1;
  DateTime _lostDate;
  String _lostDateInFormat;

  //mating
  int _heat = -1;

  @override
  void initState() {
    super.initState();
    if(widget.preview == false){
      if(widget.postMode == 0){
        _callManager.getUser(widget.adoption.ownerId).then((value){
          if(value == null){
            return;
          }
          setState(() {
            _user = value;
            _userDone = true;
          });
        });
      }
      if(widget.postMode == 1){
        _callManager.getUser(widget.missing.ownerId).then((value){
          if(value == null){
            return;
          }
          setState(() {
            _user = value;
            _userDone = true;
          });
        });
      }
      if(widget.postMode == 2){
        _callManager.getUser(widget.mating.ownerId).then((value){
          if(value == null){
            return;
          }
          setState(() {
            _user = value;
            _userDone = true;
          });
        });
      }
    }
    if (widget.postMode == 0) {
      _postTitle = widget.adoption.title;
      _postDescription = widget.adoption.description;
      _animalName = widget.adoption.name;
      _type = widget.adoption.type;
      _race = widget.adoption.race;
      _gender = widget.adoption.gender;
      _age = widget.adoption.age;
      _source = widget.adoption.source;
      _regularVaccine = widget.adoption.regularVaccine;
      _castrated = widget.adoption.castrated;

      _city = widget.adoption.city;
      _town = widget.adoption.town;
      _addressDetail = widget.adoption.addressDetail;
      _selectedPosition = LatLng(widget.adoption.latitude, widget.adoption.longitude);
      if (!widget.preview) {
        _imageList = widget.adoption.images;
        _postId = widget.adoption.postId;
        _date = widget.adoption.date;
      }
    } else if (widget.postMode == 1) {
      _postTitle = widget.missing.title;
      _postDescription = widget.missing.description;
      _animalName = widget.missing.name;
      _type = widget.missing.type;
      _race = widget.missing.race;
      _gender = widget.missing.gender;
      _age = widget.missing.age;
      _source = widget.missing.source;
      _regularVaccine = widget.missing.regularVaccine;
      _castrated = widget.missing.castrated;

      //missing
      _collar = widget.missing.collar;
      _lostDate = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.missing.missingDate));
      _lostDateInFormat = '${_lostDate.day}/${_lostDate.month}/${_lostDate.year}';

      _city = widget.missing.city;
      _town = widget.missing.town;
      _addressDetail = widget.missing.addressDetail;
      _selectedPosition = LatLng(widget.missing.latitude, widget.missing.longitude);
      if (!widget.preview) {
        _imageList = widget.missing.images;
        _postId = widget.missing.postId;
        _date = widget.missing.date;
      }
    } else if (widget.postMode == 2) {
      _postTitle = widget.mating.title;
      _postDescription = widget.mating.description;
      _animalName = widget.mating.name;
      _type = widget.mating.type;
      _race = widget.mating.race;
      _gender = widget.mating.gender;
      _age = widget.mating.age;
      _source = widget.mating.source;
      _regularVaccine = widget.mating.regularVaccine;
      _castrated = widget.mating.castrated;

      _heat = widget.mating.heat;

      _city = widget.mating.city;
      _town = widget.mating.town;
      _addressDetail = widget.mating.addressDetail;
      _selectedPosition = LatLng(widget.mating.latitude, widget.mating.longitude);
      if (!widget.preview) {
        _imageList = widget.mating.images;
        _postId = widget.mating.postId;
        _date = widget.mating.date;
      }
    }
    _markers.add(Marker(
      markerId: MarkerId('TargetPosition'),
      position: _selectedPosition,
    ));
    if(widget.preview){
      _date = DateTime.now().millisecondsSinceEpoch.toString();
    }
    _dateInFormat = '${DateTime.fromMillisecondsSinceEpoch(int.parse(_date)).day}/${DateTime.fromMillisecondsSinceEpoch(int.parse(_date)).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(_date)).year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            Color(0xFFfc9842),
            Color(0xFFfe5f75),
          ],
          center: AlignmentDirectional(1, -1),
          startAngle: 0,
          endAngle: 2.2,
          stops: [0.74, 1],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight + 6,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.transparent,
                        expandedHeight: 300.0,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    child: CarouselSlider.builder(
                                      itemCount: widget.preview ? widget.imageList.length : _imageList.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: MediaQuery.of(context).size.width - 20,
                                          height: 300,
                                          child: widget.preview ? Image.file(widget.imageList[index], fit: BoxFit.contain) : Image.network(_callManager.getImageUrl(_imageList[index]), fit: BoxFit.contain),
                                        );
                                      },
                                      options: CarouselOptions(
                                          enableInfiniteScroll: false,
                                          height: 300,
                                          initialPage: 0,
                                          autoPlay: false,
                                          viewportFraction: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              carouselIndex = index;
                                            });
                                          }),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(PageTransition(child: ImageDetailScreen(preview: widget.preview,fileImages: widget.imageList, urlImages: _imageList, offSet: carouselIndex,), type: PageTransitionType.rightToLeft));
                                    },
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: _getCarouselChips(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          collapseMode: CollapseMode.parallax,
                        ),
                        actionsIconTheme: null,
                      )
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(_postTitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),textAlign: TextAlign.center, maxLines: 2, softWrap: false, overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text('İlan sahibi bilgileri:', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w600, fontSize: 15),),
                                ),
                                SizedBox(height: 5),
                                widget.preview ? Column(
                                  children: <Widget>[
                                    AnimalDetailListTile(
                                      leadingText: 'Adı-Soyadı',
                                      trailingText: '${StaticObjects.userData.name ?? 'Guest'} ${StaticObjects.userData.surName ?? ''}',
                                    ),
                                    SizedBox(height: 4),
                                    AnimalDetailListTile(
                                      leadingText: 'E-Mail',
                                      trailingText: '${StaticObjects.userData.email ?? '----'}',
                                    ),
                                    SizedBox(height: 4),
                                    AnimalDetailListTile(
                                      leadingText: 'Telefon Numarası',
                                      trailingText: '${StaticObjects.userData.phone ?? '----'}',
                                    ),
                                    SizedBox(height: 4)
                                  ],
                                ) : Column(
                                  children: <Widget>[
                                    AnimalDetailListTile(
                                      leadingText: 'Adı-Soyadı',
                                      trailingText: _userDone ? ('${_user.name ?? 'Guest'} ${_user.surName ?? ''}') : '',
                                    ),
                                    SizedBox(height: 4),
                                    AnimalDetailListTile(
                                      leadingText: 'E-Mail',
                                      trailingText: _userDone ? ('${_user.email ?? '----'}') : '',
                                    ),
                                    SizedBox(height: 4),
                                    AnimalDetailListTile(
                                      leadingText: 'Telefon Numarası',
                                      trailingText: _userDone ? ('${_user.phone ?? '----'}') : '',
                                    ),
                                    SizedBox(height: 4)
                                  ],
                                )

                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text('İlan açıklaması:', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w600, fontSize: 15),),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1,
                                  color: Colors.grey[400],
                                  width: MediaQuery.of(context).size.width,
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  child: Text(_postDescription, style: TextStyle(color: Colors.grey[700]),),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               SizedBox(
                                 width: MediaQuery.of(context).size.width,
                                 child: Text('İlan bilgileri:', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w600, fontSize: 15),),
                               ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1,
                                  color: Colors.grey[400],
                                  width: MediaQuery.of(context).size.width,
                                ),
                                SizedBox(height: 5),
                                AnimalDetailListTile(
                                  leadingText: 'İlan tarihi',
                                  trailingText: _dateInFormat,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'İlan numarası',
                                  trailingText: widget.preview ? '---' : _postId,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'İlan tipi',
                                  trailingText: widget.postMode == 0 ? 'Sahiplendirme': widget.postMode == 1 ? 'Kayıp': 'Çiftleştirme',
                                ),
                                Visibility(
                                  visible: widget.postMode == 1,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 5),
                                      AnimalDetailListTile(
                                        leadingText: 'Kaybolduğu tarih',
                                        trailingText: _lostDateInFormat,
                                      ),
                                      SizedBox(height: 5),
                                      AnimalDetailListTile(
                                        leadingText: 'Tasması takılı mı',
                                        trailingText: _collar == 0 ? 'Takılı': _collar == 1 ? 'Takılı değil': 'Bilinmiyor',
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: widget.postMode == 2,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 5),
                                      AnimalDetailListTile(
                                        leadingText: 'Kızgınlık  durumu',
                                        trailingText: _heat == 0 ? 'Kızgınlık döneminde' : _heat == 1 ? 'Kızgınlık döneminde değil' : 'Bilinmiyor',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Adı',
                                  trailingText: _animalName,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Türü',
                                  trailingText: _type,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Cinsi',
                                  trailingText: _race,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Yaşı (Ay)',
                                  trailingText: _age,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Cinsiyeti',
                                  trailingText: _gender,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Kimden',
                                  trailingText: _source,
                                ),
                                SizedBox(height: 4),
                                AnimalDetailListTile(
                                  leadingText: 'Aşı takibi',
                                  trailingText: _regularVaccine == 0? 'Yapıldı' : _regularVaccine == 1 ? 'Yapılmadı' : 'Bilinmiyor',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition:  CameraPosition(
                                    target: _selectedPosition,
                                    zoom: 14
                                ),
                                markers: Set<Marker>.of(_markers),
                                onMapCreated: (GoogleMapController controller) {

                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        top: BorderSide(color: Colors.white),
                      )),
                  height: 50,
                  child: widget.preview ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xff0367BD),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text('İlan paylaş', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                        ),
                        onTap: () {
                          final ProgressDialog pr = ProgressDialog(context);
                          pr.style(
                              message: 'Lütfen bekleyin',
                              borderRadius: 10.0,
                              backgroundColor: Colors.white,
                              progressWidget: CircularProgressIndicator(),
                              elevation: 10.0,
                              insetAnimCurve: Curves.easeInOut,
                              progressTextStyle: TextStyle(
                                  color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                              messageTextStyle: TextStyle(
                                  color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
                          );
                          pr.show();

                          if (widget.postMode == 0) {
                            _callManager.createAdoptionPost(
                                postTitle: _postTitle,
                                postDescription: _postDescription,
                                position: _selectedPosition,
                                animalName: _animalName,
                                age: _age,
                                animalType: _type,
                                animalRace: _race,
                                gender: _gender,
                                source: _source,
                                images: widget.imageList,
                                regularVaccine: _regularVaccine,
                                castrated: _castrated,
                                city: _city,
                                town: _town,
                                addressDetail: _addressDetail).then((value){
                                  if(value != null){
                                    pr.hide();
                                    Fluttertoast.showToast(msg: 'İlan başarıyla paylaşıldı');
                                    Navigator.of(context).pushAndRemoveUntil(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft), (route) => false);
                                  }else{
                                    pr.hide();
                                    Fluttertoast.showToast(msg: 'İlan paylaşırken bir hata meydana geldi');
                                  }
                            });
                          } else if (widget.postMode == 1) {
                            _callManager.createMissingPost(
                                collar: _collar,
                                missingDate: _lostDate.millisecondsSinceEpoch.toString(),
                                postTitle: _postTitle,
                                postDescription: _postDescription,
                                position: _selectedPosition,
                                animalName: _animalName,
                                age: _age,
                                animalType: _type,
                                animalRace: _race,
                                gender: _gender,
                                source: _source,
                                images: widget.imageList,
                                regularVaccine: _regularVaccine,
                                castrated: _castrated,
                                city: _city,
                                town: _town,
                                addressDetail: _addressDetail).then((value){
                              if(value != null){
                                pr.hide();
                                Fluttertoast.showToast(msg: 'İlan başarıyla paylaşıldı');
                                Navigator.of(context).pushAndRemoveUntil(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft), (route) => false);
                              }else{
                                pr.hide();
                                Fluttertoast.showToast(msg: 'İlan paylaşırken bir hata meydana geldi');
                              }
                            });
                          } else if (widget.postMode == 2) {
                            _callManager.createMatingPost(
                                heat: _heat,
                                postTitle: _postTitle,
                                postDescription: _postDescription,
                                position: _selectedPosition,
                                animalName: _animalName,
                                age: _age,
                                animalType: _type,
                                animalRace: _race,
                                gender: _gender,
                                source: _source,
                                images: widget.imageList,
                                regularVaccine: _regularVaccine,
                                castrated: _castrated,
                                city: _city,
                                town: _town,
                                addressDetail: _addressDetail).then((value){
                              if(value != null){
                                pr.hide();
                                Fluttertoast.showToast(msg: 'İlan başarıyla paylaşıldı');
                                Navigator.of(context).pushAndRemoveUntil(PageTransition(child: BottomNavigationPage(), type: PageTransitionType.rightToLeft), (route) => false);
                              }else{
                                pr.hide();
                                Fluttertoast.showToast(msg: 'İlan paylaşırken bir hata meydana geldi');
                              }
                            });
                          }
                        },
                      ),
                      SizedBox(width: 30),
                    ],
                  ):
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xff0367BD),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text('İlan Sahibini Ara', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                            ),
                            onTap: (){
                              Fluttertoast.showToast(msg: 'Bu özellik şuan aktif değil');
                            },
                          ),
                          SizedBox(width: 30),
                        ],
                      )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getCarouselChips() {
    List<Widget> _chips = List();
    for (int i = 0; i < (widget.preview ? widget.imageList.length : _imageList.length); i++) {
      _chips.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: i == carouselIndex ? 24 : 12,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: i == carouselIndex ? Colors.green : Colors.white,
          ),
        ),
      ));
    }
    return _chips;
  }
}
