
import 'package:warm_hearts_flutter/data/animal_category/AnimalCategory.dart';
import 'package:warm_hearts_flutter/data/city/CityItem.dart';
import 'package:warm_hearts_flutter/data/post/Adoption.dart';
import 'package:warm_hearts_flutter/data/post/Mating.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
import 'package:warm_hearts_flutter/data/user/User.dart';

class StaticObjects{
  static const int PAGE_MODE_HOME = 0;
  static const int PAGE_MODE_STORE = 1;
  static const int PAGE_MODE_CHAT = 2;
  static const int PAGE_MODE_ACCOUNT = 3;

  static bool loginStatus = false;
  static User userData;
  static String accessToken;

  static List<AnimalCategory> animalCategoryList = List();
  static List<CityItem> cityList = List();
  static List<Adoption> adoptionList = List();
  static List<Missing> missingList = List();
  static List<Mating> matingList = List();

}