import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
import 'dart:convert';
import 'package:warm_hearts_flutter/data/user/UserModel.dart';

class CallManager{
  final String _localIpAddress = '192.168.1.28';
  final String _port = '5000';

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
      StaticObjects.userData = userModel.user;
      StaticObjects.loginStatus = true;
      StaticObjects.accessToken= userModel.token;
    }
    return userModel;
  }

  Future<String> getUsers() async{
    String url = 'http://$_localIpAddress:$_port/users';
    http.Response response = await http.get(url);
    String budu = response.body;
    return response.body;
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

}
