import 'dart:convert';

import 'package:crypto/crypto.dart';
class CryptoManager {

  String encryptStringSha256(String text){
    var bytes = utf8.encode(text);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}