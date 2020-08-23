import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';
import 'package:warm_hearts_flutter/data/animal_category/AnimalCategory.dart';
import 'package:warm_hearts_flutter/data/animal_category/AnimalRace.dart';
import 'package:warm_hearts_flutter/data/city/CityItem.dart';
import 'package:warm_hearts_flutter/data/city/DistrictItem.dart';

class CreateNewPostPage extends StatefulWidget {
  const CreateNewPostPage();

  @override
  _CreateNewPostPageState createState() => _CreateNewPostPageState();
}

class _CreateNewPostPageState extends State<CreateNewPostPage> {
  final picker = ImagePicker();
  CallManager _callManager = CallManager();
  List<File> _imageList = List();
  int _stage = 0;
  int carouselIndex = 0;
  int selectedPostType = 0; /// 0 -> Adoptation 1 -> missing, 2 -> mating

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
  double _latitude;
  double _longitude;

  //missing
  int _collar = -1;
  DateTime _lostDate;

  //mating
  int _heat = -1;

  @override
  void initState() {
    super.initState();

  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      List<File> tempImages = List.from(_imageList);
      tempImages.add(File(pickedFile.path));
      _imageList = List.from(tempImages);
    });
  }


  Future<bool>_handlePageMode() async{
    Completer _completer = Completer<bool>();
    print(_stage.toString());
    if(_stage == 0){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.only(top: 15, right: 10, left: 10),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text('Geri dönmek istediğinizden emin misiniz?', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600)),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Evet', style: TextStyle(color: Colors.grey[900])),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.grey[200],
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text('Hayır', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              SizedBox(width: 5)
            ],
          )).then((value){
        _completer.complete(value);
      });
    }else{
      setState(() {
        _stage = _stage -1;
        _completer.complete(false);
      });
    }
    return _completer.future;
  }

  String _handleTitle(){
    if(_stage == 0){
      return 'Temel Bilgiler';
    }else{
      return 'Fotograf ve adres bilgileri';
    }
  }

  String _handleButtonTitle(){
    if(_stage == 0){
      return 'Devam Et (1/2) ';
    }else{
      return 'Tamamla (2/2)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handlePageMode,
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(_handleTitle(), style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _handlePageMode().then((value){
                  if(value){
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    print(constraints.maxHeight.toString());
                    print(MediaQuery.of(context).size.height);
                    return SizedBox(
                      height: constraints.maxHeight - 50,
                      width: MediaQuery.of(context).size.width,
                      child: ScrollConfiguration(
                        behavior: new ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
                        child: SingleChildScrollView(
                          child: _handleBody(),
                        ),
                      ),
                    );
                  },
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xff0367BD),
                            ),
                            child: Text(_handleButtonTitle(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                          ),
                          onTap: () {
                            if(_stage == 0){
                              if(_validateFirstStage() == false){
                                Fluttertoast.showToast(msg: 'Lütfen gerekli alanları doldurun ve tekrar deneyin');
                                return;
                              }
                              setState(() {
                                _stage = 1;
                              });
                            }else{
                              if(_validateSecondStage() == false){
                                Fluttertoast.showToast(msg: 'Lütfen gerekli alanları doldurun ve en az 3 resim seçin');
                              }else{
                                _callManager.createAdoptionPost(animalName: _animalName, age: _age,
                                    animalType: _type, animalRace: _race, gender: _gender, source: _source,
                                images: _imageList, regularVaccine: _regularVaccine, castrated: _castrated, city: _city, town: _town, addressDetail: _addressDetail);
                              }
                            }
                          },
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateFirstStage(){
    int generalCheck = 0;
    int missingCheck = 0;
    int matingCheck = 0;
    //animal info
    generalCheck+= (_animalName == null || _animalName == '') ? 0 : 1;
    generalCheck+= _type == null ? 0 : 1;
    generalCheck+= _race == null ? 0 : 1;
    generalCheck+= _gender == null ? 0 : 1;
    generalCheck+= (_age == null || _age == '') == null ? 0 : 1;
    generalCheck+= _source == null ? 0 : 1;
    generalCheck+= _regularVaccine == -1 ? 0 : 1;
    generalCheck+= _castrated == -1 ? 0 : 1;
    //missing
    missingCheck+= _collar == -1 ? 0 : 1;
    missingCheck+= _lostDate == null ? 0 : 1;
    //mating
    matingCheck+= _heat == -1 ? 0 : 1;
    if(selectedPostType == 0){
      return generalCheck == 8;
    }else if(selectedPostType == 1){
      return (generalCheck + missingCheck) == 10;
    }else{
      return (generalCheck + matingCheck) == 9;
    }

  }

  bool _validateSecondStage(){
    int addressCheck = 0;
    addressCheck+= (_city == null || _city == '') ? 0 : 1;
    addressCheck+= (_town == null || _town == '') ? 0 : 1;
    addressCheck+= (_addressDetail == null || _addressDetail == '') ? 0 : 1;
    return addressCheck + _imageList.length == 6;
  }

  List<Widget> _getCarouselChips(){
    List<Widget> _chips = List();
    for(int i = 0; i< _imageList.length + 1; i++){
      _chips.add(
        Padding(
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
        )
      );
    }
    return _chips;
  }

  Widget _handleBody(){
    if(_stage == 0){
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: selectedPostType == 0 ? Colors.green : Colors.white
                        ),
                        child: Center(
                          child: Text('Sahiplendirme',style: TextStyle(color: selectedPostType == 0 ? Colors.white : Colors.grey[700]),),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          selectedPostType = 0;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: selectedPostType == 1 ? Colors.green : Colors.white
                        ),
                        child: Center(
                          child: Text('Kayıp', style: TextStyle(color: selectedPostType == 1 ? Colors.white : Colors.grey[700])),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          selectedPostType = 1;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: selectedPostType == 2 ? Colors.green : Colors.white
                        ),
                        child: Center(
                          child: Text('Çiftleştirme', style: TextStyle(color: selectedPostType == 2 ? Colors.white : Colors.grey[700])),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          selectedPostType = 2;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Adı*',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(_animalName ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _stringDialog(title: 'Adı', parameter: _animalName);
                  }).then((data) {
                if (data != null) {
                  if(data == ''){
                    setState(() {
                      _animalName = null;
                    });
                    return;
                  }
                  setState(() {
                    _animalName = data;
                  });
                }
              });
            },
          ),
          ListTile(
            title: Text('Türü*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_type ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownAnimalCategoryDialog(title: 'Türü', parameter: _type, dataList: StaticObjects.animalCategoryList);
                  }).then((data) {
                if (data != null) {
                  if (_type != data) {
                    setState(() {
                      _type = data;
                      _race = null;
                    });
                  }
                }
              });
            },
          ),
          ListTile(
            title: Text('Irkı*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_race ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              if (_type == null || _type == '') {
                Fluttertoast.showToast(msg: 'Lütfen Önce Tür Seçiniz');
                return;
              }
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownAnimalRaceDialog(title: 'Irkı', parameter: _race, type: _type);
                  }).then((data) {
                if (data != null) {
                  setState(() {
                    _race = data;
                  });
                }
              });
            },
          ),
          ListTile(
            title: Text('Cinsiyeti*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_gender ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownGenderDialog(title: 'Cinsiyeti', parameter: _gender);
                  }).then((data) {
                if (data != null) {
                  setState(() {
                    _gender = data;
                  });
                }
              });
            },
          ),
          ListTile(
            title: Text('Yaşı (ay)*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_age ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _stringDialog(title: 'Yaşı (ay)', parameter: _age, keyboardType: TextInputType.number);
                  }).then((data) {
                if (data != null) {
                  if(data == ''){
                    setState(() {
                      _age = null;
                    });
                    return;
                  }
                  setState(() {
                    _age = data;
                  });
                }
              });
            },
          ),
          ListTile(
              title: Text('Düzenli aşı takibi yapıldı mı*', style: TextStyle(color: Colors.white)),
              subtitle: Text(_boolDropdownResult2String(_regularVaccine), style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.more_horiz),
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return _dropDownBool(title: 'Aşı Takibi', parameter: _regularVaccine);
                    }).then((data) {
                  if (data != null) {
                    setState(() {
                      _regularVaccine = data;
                    });
                  }
                });
              }),
          ListTile(
            title: Text('Kısırlaştırılmış*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_boolDropdownResult2String(_castrated) ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownBool(title: 'Kısırlaştırılmış', parameter: _castrated);
                  }).then((data) {
                if (data != null) {
                  setState(() {
                    _castrated = data;
                  });
                }
              });
            },
          ),
          ListTile(
            title: Text('Kimden*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_source ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownOwnerTypeDialog(title: 'Kimden', parameter: _source);
                  }).then((data) {
                if (data != null) {
                  setState(() {
                    _source = data;
                  });
                }
              });
            },
          ),
          Visibility(
            visible: selectedPostType == 1,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Kaybolduğu Tarih*', style: TextStyle(color: Colors.white)),
                  subtitle: Text(_lostDate == null ? '' : '${_lostDate.day}/${_lostDate.month}/${_lostDate.year}', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.more_horiz),
                  onTap: () => _selectDate(context, _lostDate),
                ),
                ListTile(
                  title: Text('Kaybolduğunda tasması varmıydı*', style: TextStyle(color: Colors.white)),
                  subtitle: Text(_boolDropdownResult2String(_collar), style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.more_horiz),
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return _dropDownBool(title: 'Kaybolduğunda tasması varmıydı', parameter: _collar);
                        }).then((data) {
                      if (data != null) {
                        setState(() {
                          _collar = data;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: selectedPostType == 2,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Kızgınlık Döneminde mi*', style: TextStyle(color: Colors.white)),
                  subtitle: Text(_boolDropdownResult2String(_heat), style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.more_horiz),
                  onTap: (){
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return _dropDownBool(title: 'Kızgınlık Döneminde mi', parameter: _heat);
                        }).then((data) {
                      if (data != null) {
                        setState(() {
                          _heat = data;
                        });
                      }
                    });
                  }
                ),
              ],
            ),
          )
        ],
      );
    }else{
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Stack(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: _imageList.length + 1,
                  itemBuilder: (context, index){
                    if(_imageList.length > 0 && index < _imageList.length){
                      return Stack(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 300,
                            child: Image.file(_imageList[index], fit: BoxFit.contain),
                          ),
                          Positioned(
                            top: 0,
                            right : 0,
                            child: IconButton(
                              icon: Icon(Icons.cancel, color: Colors.white),
                              onPressed: (){
                                setState(() {
                                  _imageList.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return GestureDetector(
                      child: Container(
                        //width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add, color: Colors.green, size: 16,),
                              SizedBox(height: 8),
                              Text('Fotoğraf eklemek için tıklayın', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        if(_imageList.length == 3){
                          Fluttertoast.showToast(msg: 'En fazla 3 fotoğraf seçebilirsiniz');
                        }else{
                          getImage();
                        }
                      },
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                      height: 250,
                      initialPage: 0,
                      autoPlay: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          carouselIndex = index;
                        });
                      }),
                ),
                Positioned(
                  bottom: 0,
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
          ListTile(
            title: Text('Şehir*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_city ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownCityDialog(title: 'Şehir', parameter: _city, dataList: StaticObjects.cityList);
                  }).then((data) {
                if (data != null) {
                  if (_city != data) {
                    setState(() {
                      _city = data;
                      _town = null;
                    });
                  }
                }
              });
            },
          ),
          ListTile(
            title: Text('İlçe*', style: TextStyle(color: Colors.white)),
            subtitle: Text(_town ?? '', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              if (_city == null || _city == '') {
                Fluttertoast.showToast(msg: 'Lütfen Önce Şehir Seçiniz');
                return;
              }
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return _dropDownDistrictDialog(title: 'İlçe', parameter: _town, city: _city);
                  }).then((data) {
                if (data != null) {
                  setState(() {
                    _town = data;
                  });
                }
              });
            },
          ),
          ListTile(
            title: Text('Adres Detay*', style: TextStyle(color: Colors.white)),
            subtitle: Text( _addressDetail ?? '', style: TextStyle(color: Colors.white), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
            trailing: Icon(Icons.more_horiz),
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context){
                  return _longStringDialog(title: 'Adres Detay', parameter: _addressDetail);
                }
              ).then((data){
                if(data != null){
                  setState(() {
                    _addressDetail = data;
                  });
                }
              });
            },
          ),
        ],
      );
    }
  }


  String _boolDropdownResult2String(int value) {
    if (value == -1) {
      return '';
    }
    switch (value) {
      case -1:
        return '';
      case 0:
        return 'Evet';
      case 1:
        return 'Hayır';
      case 2:
        return 'Bilmiyorum';
      default:
        return 'Bilmiyorum';
    }
  }

  _dropDownCityDialog({String title, String parameter, List<CityItem> dataList}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (String state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: dataList.map((e) {
                    return DropdownMenuItem<String>(
                      child: Text(e.cityName),
                      value: e.cityName,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _dropDownDistrictDialog({String title, String parameter, String city}) {
    List<DistrictItem> dataList;
    for (int i = 0; i < StaticObjects.cityList.length; i++) {
      if (StaticObjects.cityList[i].cityName == city) {
        dataList = StaticObjects.cityList[i].districts;
        break;
      }
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (String state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: dataList.map((e) {
                    return DropdownMenuItem<String>(
                      child: Text(e.districtName),
                      value: e.districtName,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _dropDownAnimalCategoryDialog({String title, String parameter, List<AnimalCategory> dataList}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (String state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: dataList.map((e) {
                    return DropdownMenuItem<String>(
                      child: Text(e.type),
                      value: e.type,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _dropDownAnimalRaceDialog({String title, String parameter, String type}) {
    List<AnimalRace> dataList;
    for (int i = 0; i < StaticObjects.animalCategoryList.length; i++) {
      if (StaticObjects.animalCategoryList[i].type == type) {
        dataList = StaticObjects.animalCategoryList[i].races;
        break;
      }
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (String state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: dataList.map((e) {
                    return DropdownMenuItem<String>(
                      child: Text(e.race),
                      value: e.race,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _dropDownGenderDialog({String title, String parameter}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (String state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Erkek'),
                      value: 'Erkek',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Dişi'),
                      value: 'Dişi',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Diğer'),
                      value: 'Diğer',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _dropDownBool({String title, int parameter}) {
    print(parameter);
    if (parameter == -1) {
      parameter = null;
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (int state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: [
                    DropdownMenuItem<int>(
                      child: Text('Evet'),
                      value: 0,
                    ),
                    DropdownMenuItem<int>(
                      child: Text('Hayır'),
                      value: 1,
                    ),
                    DropdownMenuItem<int>(
                      child: Text('Bilmiyorum'),
                      value: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _dropDownOwnerTypeDialog({String title, String parameter}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: parameter,
                  onChanged: (String state) {
                    setState(() {
                      parameter = state;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Sahibinden'),
                      value: 'Sahibinden',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Barınaktan'),
                      value: 'Barınaktan',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Diğer'),
                      value: 'Diğer',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(parameter);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _stringDialog({String title, String parameter, TextInputType keyboardType}) {
    FocusNode _fc = FocusNode();
    TextEditingController _tc = TextEditingController();
    _tc.text = parameter ?? '';
    return AlertDialog(
      backgroundColor: Colors.grey[100],
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
      ),
      content: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              style: TextStyle(fontSize: 17, color: Colors.grey[800]),
              obscureText: false,
              maxLines: 1,
              focusNode: _fc,
              controller: _tc,
              keyboardType: keyboardType ?? TextInputType.text,
              textInputAction: TextInputAction.next,
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
                _fc.unfocus();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Spacer(),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      'Vaz Geç',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(null);
                  },
                ),
                SizedBox(width: 5),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(_tc.text.trim());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _longStringDialog({String title, String parameter}) {
    FocusNode _fc = FocusNode();
    TextEditingController _tc = TextEditingController();
    _tc.text = parameter ?? '';
    return AlertDialog(
      backgroundColor: Colors.grey[100],
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                style: TextStyle(fontSize: 17, color: Colors.grey[800]),
                obscureText: false,
                minLines: 5,
                maxLines: 20,
                maxLength: 200,
                focusNode: _fc,
                controller: _tc,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.4, color: Color(0x33000000)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.4, color: Color(0x33000000)),
                  ),
                ),
                onFieldSubmitted: (term) {
                  _fc.unfocus();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text(
                        'Vaz Geç',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text('Onayla', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(_tc.text.trim());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context, DateTime parameter) async {
    final DateTime picked =
        await showDatePicker(context: context, locale: Locale("tr", "TR"), initialDate: parameter ?? DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != _lostDate)
      setState(() {
        _lostDate = picked;
      });
  }
}
