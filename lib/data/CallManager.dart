import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/animal_category/AnimalCategory.dart';
import 'package:warm_hearts_flutter/data/animal_category/AnimalCategoryModel.dart';
import 'package:warm_hearts_flutter/data/city/CityModel.dart';
import 'package:warm_hearts_flutter/data/post/Adoption.dart';
import 'package:warm_hearts_flutter/data/post/AdoptionModel.dart';
import 'package:warm_hearts_flutter/data/post/MatingModel.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
import 'package:warm_hearts_flutter/data/post/MissingModel.dart';
import 'dart:convert';
import 'package:warm_hearts_flutter/data/user/UserModel.dart';

import 'city/CityItem.dart';

class CallManager{
  final String _localIpAddress = '192.168.1.28';
  final String _port = '5000';
  final Duration _timeOut = Duration(seconds: 15);
  String appSecret = 'VSDF8-ASD78-RTLOP-66FDS-RT437';
  String appKey = '12364900746';

  Future<UserModel> signIn({@required String email, @required String password}) async{
    String url = 'http://$_localIpAddress:$_port/users/signin';
    Map body = {
      'email': email,
      'password': password,
    };
    print(body);
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body));
    print(response.body);
    var decodedBody = json.decode(response.body);
    UserModel userModel =  UserModel.fromJson(decodedBody);
    if(userModel.success){
      userModel.user.accessToken = userModel.token;
      StaticObjects.userData = userModel.user;
      StaticObjects.loginStatus = true;
      StaticObjects.accessToken= userModel.token;
    }
    return userModel;
  }

  Future<UserModel> signUp({@required String email, @required String password, String firstName = '', String lastName = ''}) async{
    String url = 'http://$_localIpAddress:$_port/users/signup';
    Map body = {
      'email': email,
      'password': password,
      'firstname': firstName,
      'lastname': lastName,
    };
    print(body);
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body));
    print(response.body);
    var decodedBody = json.decode(response.body);
    UserModel userModel =  UserModel.fromJson(decodedBody);
    if(userModel.success){
      userModel.user.accessToken = userModel.token;
      StaticObjects.userData = userModel.user;
      StaticObjects.loginStatus = true;
      StaticObjects.accessToken= userModel.token;
    }
    return userModel;
  }

  Future<List<AnimalCategory>> getAnimalCategories() async{
    String url = 'http://$_localIpAddress:$_port/static/animalData';
    http.Response response = await http.get(url);
    Map<String, dynamic> decodedBody = json.decode(response.body);
    AnimalCategoryModel animalCategoryModel = AnimalCategoryModel.fromJson(decodedBody);
    StaticObjects.animalCategoryList = animalCategoryModel.animalData;
    return animalCategoryModel.animalData;
  }

  Future<String> getUsers() async{
    String url = 'http://$_localIpAddress:$_port/users';
    http.Response response = await http.get(url);
    String budu = response.body;
    return response.body;
  }

  Future<List<CityItem>> getCities() async {
    String url = 'https://api.icgiyimozel.com/appigo/GetAllCities.cfm';
    String body = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body><GetAllCities><auth><appKey>$appKey</appKey><appSecret>$appSecret</appSecret></auth></GetAllCities></soapenv:Body></soapenv:Envelope>';
    http.Response response = await http.post(url, body: utf8.encode(body));
    CityModel cityModel = CityModel.fromJson(json.decode(response.body));
    return cityModel.cities;
  }

  Future<List<Missing>> getMissing() async{
    String url = 'http://$_localIpAddress:$_port/posts/missing';
    http.Response response = await http.get(url);
    Map<String, dynamic> decodedBody =  json.decode(response.body);
    List<Missing> missingList = List();
    if(decodedBody['Success'] as bool == true){
      for(dynamic e in (decodedBody['result'] as List)){
        missingList.add(Missing.fromJson(e));
      }
    }
    return missingList;
  }

  Future<String> getMating() async{
    String url = 'http://$_localIpAddress:$_port/posts/missing';
    http.Response response = await http.get(url);
    String budu =  response.body;
    return budu;
  }

  Future<String> getAdoption() async{
    String url = 'http://$_localIpAddress:$_port/posts/missing';
    http.Response response = await http.get(url);
    String budu =  response.body;
    return budu;
  }

  Future<Adoption> createAdoptionPost({String animalName, String animalType, String animalRace, String gender, String age, int regularVaccine, int castrated, String source, String city, String town, String addressDetail, String postTitle, String postDescription, LatLng position, List<File> images}) async{
    Completer callCompleter = Completer<Adoption>();
    Timer timeOut = Timer(_timeOut, (){
      callCompleter.complete(null);
    });
    String url = 'http://$_localIpAddress:$_port/posts/adoption';
    Map<String, dynamic> callBody = Map();
    Map<String, dynamic> adoptionBody = Map();
    adoptionBody['ownerId'] = StaticObjects.userData.userId;
    adoptionBody['postId'] = '${StaticObjects.userData.userId}-${DateTime.now().millisecondsSinceEpoch}';
    adoptionBody['postId'] = '';
    adoptionBody['date'] = DateTime.now().millisecondsSinceEpoch.toString();
    adoptionBody['animalName'] = animalName;
    adoptionBody['castrated'] = castrated;
    adoptionBody['type'] = animalType;
    adoptionBody['race'] = animalRace;
    adoptionBody['gender'] = gender;
    adoptionBody['age'] = age;
    adoptionBody['source'] = source;
    adoptionBody['regularVaccine'] = regularVaccine;
    adoptionBody['city'] = city;
    adoptionBody['town'] = town;
    adoptionBody['title'] = postTitle;
    adoptionBody['description'] = postDescription;
    adoptionBody['addressDetail'] = addressDetail;
    adoptionBody['latitude'] = position.latitude ?? 0.0;
    adoptionBody['longitude'] = position.longitude ?? 0.0;

    callBody['token'] = StaticObjects.accessToken;
    callBody['email'] = StaticObjects.userData.email;
    callBody['password'] = StaticObjects.userData.password;
    callBody['adoption'] = adoptionBody;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
    for(File f in images){
      request.files.add(
          await http.MultipartFile.fromPath(
              'fileToUpload',
              f.path
          )
      );
    }
    String _callText = json.encode(callBody);
    Map<String, String> _callMap = Map();
    _callMap['callBody'] = _callText;
    request.fields.addAll(_callMap);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((event) {
      timeOut.cancel();
      var decodedBody = json.decode(event);
      if(decodedBody['success'] as bool){
        AdoptionModel adoptionModel = AdoptionModel.fromJson(decodedBody);
        callCompleter.complete(adoptionModel);
      } else{
        callCompleter.complete(null);
      }
    });
    return callCompleter.future;
  }

  Future<Adoption> createMissingPost({String missingDate, int collar, String animalName, String animalType, String animalRace, String gender, String age, int regularVaccine, int castrated, String source, String city, String town, String addressDetail, String postTitle, String postDescription, LatLng position, List<File> images}) async{
    Completer callCompleter = Completer<Adoption>();
    Timer timeOut = Timer(_timeOut, (){
      callCompleter.complete(null);
    });
    String url = 'http://$_localIpAddress:$_port/posts/adoption';
    Map<String, dynamic> callBody = Map();
    Map<String, dynamic> missingBody = Map();
    missingBody['ownerId'] = StaticObjects.userData.userId;
    missingBody['postId'] = '${StaticObjects.userData.userId}-${DateTime.now().millisecondsSinceEpoch}';
    missingBody['postId'] = '';
    missingBody['date'] = DateTime.now().millisecondsSinceEpoch.toString();
    missingBody['animalName'] = animalName;
    missingBody['castrated'] = castrated;
    missingBody['type'] = animalType;
    missingBody['race'] = animalRace;
    missingBody['gender'] = gender;
    missingBody['age'] = age;
    missingBody['source'] = source;
    missingBody['regularVaccine'] = regularVaccine;
    missingBody['missingDate'] = missingDate;
    missingBody['collar'] = collar;
    missingBody['city'] = city;
    missingBody['town'] = town;
    missingBody['title'] = postTitle;
    missingBody['description'] = postDescription;
    missingBody['addressDetail'] = addressDetail;
    missingBody['latitude'] = position.latitude ?? 0.0;
    missingBody['longitude'] = position.longitude ?? 0.0;

    callBody['token'] = StaticObjects.accessToken;
    callBody['email'] = StaticObjects.userData.email;
    callBody['password'] = StaticObjects.userData.password;
    callBody['missing'] = missingBody;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
    for(File f in images){
      request.files.add(
          await http.MultipartFile.fromPath(
              'fileToUpload',
              f.path
          )
      );
    }
    String _callText = json.encode(callBody);
    Map<String, String> _callMap = Map();
    _callMap['callBody'] = _callText;
    request.fields.addAll(_callMap);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((event) {
      timeOut.cancel();
      var decodedBody = json.decode(event);
      if(decodedBody['success'] as bool){
        MissingModel missingModel = MissingModel.fromJson(decodedBody);
        callCompleter.complete(missingModel);
      }else{
        callCompleter.complete(null);
      }
    });
    return callCompleter.future;
  }

  Future<Adoption> createMatingPost({int heat, String animalName, String animalType, String animalRace, String gender, String age, int regularVaccine, int castrated, String source, String city, String town, String addressDetail, String postTitle, String postDescription, LatLng position, List<File> images}) async{
    Completer callCompleter = Completer<Adoption>();
    Timer timeOut = Timer(_timeOut, (){
      callCompleter.complete(null);
    });
    String url = 'http://$_localIpAddress:$_port/posts/adoption';
    Map<String, dynamic> callBody = Map();
    Map<String, dynamic> matingBody = Map();
    matingBody['ownerId'] = StaticObjects.userData.userId;
    matingBody['postId'] = '${StaticObjects.userData.userId}-${DateTime.now().millisecondsSinceEpoch}';
    matingBody['postId'] = '';
    matingBody['date'] = DateTime.now().millisecondsSinceEpoch.toString();
    matingBody['animalName'] = animalName;
    matingBody['castrated'] = castrated;
    matingBody['type'] = animalType;
    matingBody['race'] = animalRace;
    matingBody['gender'] = gender;
    matingBody['age'] = age;
    matingBody['source'] = source;
    matingBody['regularVaccine'] = regularVaccine;
    matingBody['heat'] = heat;
    matingBody['city'] = city;
    matingBody['town'] = town;
    matingBody['title'] = postTitle;
    matingBody['description'] = postDescription;
    matingBody['addressDetail'] = addressDetail;
    matingBody['latitude'] = position.latitude ?? 0.0;
    matingBody['longitude'] = position.longitude ?? 0.0;

    callBody['token'] = StaticObjects.accessToken;
    callBody['email'] = StaticObjects.userData.email;
    callBody['password'] = StaticObjects.userData.password;
    callBody['mating'] = matingBody;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
    for(File f in images){
      request.files.add(
          await http.MultipartFile.fromPath(
              'fileToUpload',
              f.path
          )
      );
    }
    String _callText = json.encode(callBody);
    Map<String, String> _callMap = Map();
    _callMap['callBody'] = _callText;
    request.fields.addAll(_callMap);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((event) {
      timeOut.cancel();
      var decodedBody = json.decode(event);
      if(decodedBody['success'] as bool){
        MatingModel matingModel = MatingModel.fromJson(decodedBody);
        callCompleter.complete(matingModel);
      }else{
        callCompleter.complete(null);
      }
    });
    return callCompleter.future;
  }

}
