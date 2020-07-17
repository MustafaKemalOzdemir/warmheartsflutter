import 'package:http/http.dart' as http;
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/user/User.dart';
import 'dart:convert';
import 'package:warm_hearts_flutter/data/user/UserModel.dart';

class CallManager{

  Future<String> getPosts() async{
    String url = 'http://10.0.2.2:5000/posts';
    http.Response response = await http.get(url);
    print(response.body);
    return response.body;
  }

  Future<UserModel> signIn(String email, String password) async{
    String url = 'http://10.0.2.2:5000/users/signin';
    Map body = {
      'email': email,
      'password': password
    };

    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body));
    String budu = response.body;
    var decodedBody = json.decode(response.body);

    UserModel userModel =  UserModel.fromJson(decodedBody);
    if(userModel.success){
      StaticObjects.userData = userModel.user;
      StaticObjects.loginStatus = true;
    }
    return userModel;
  }

}
