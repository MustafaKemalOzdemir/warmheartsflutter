import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:warm_hearts_flutter/constants/Constants.dart';
import 'package:warm_hearts_flutter/data/user/User.dart';

class DataManager {
  final _storage = FlutterSecureStorage();

  void writeUser(User user){
    String jsonForm = json.encode(user.toJson());
    _storage.write(key: Constants.SS_USER_INFO, value: jsonForm);
  }

  Future<User> readUser() async{
    String userJson = await _storage.read(key: Constants.SS_USER_INFO);
    if(userJson != null && userJson != ''){
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }

  void clearUser(){
    _storage.delete(key: Constants.SS_USER_INFO);
  }

}