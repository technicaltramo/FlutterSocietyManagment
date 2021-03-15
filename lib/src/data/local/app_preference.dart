import 'package:get/get.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppPreference {
  static SharedPreferences _sharedPreferences;
  static AppPreference _appPreference;

  static Future init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _appPreference = AppPreference();
    }
    return _appPreference;
  }

  User get user =>
      User.fromJson(json.decode(_sharedPreferences.getString(USER)));

  set user(User user) =>
      _sharedPreferences.setString(USER, json.encode(user.toJson()));

  String get email => _sharedPreferences.get(EMAIL);

  set email(String value) => _sharedPreferences.setString(EMAIL, value);

  String get password => _sharedPreferences.get(PASSWORD);

  set password(String value) => _sharedPreferences.setString(PASSWORD, value);

  String get token => _sharedPreferences.get(TOKEN);

  set token(String value) => _sharedPreferences.setString(TOKEN, value);

  Visitor get visitor {
    var strData = _sharedPreferences.getString(VISITOR_INFO);
    if(strData == null) return null;
    else return Visitor.fromJson(json.decode(strData));
  }

  set visitor(Visitor info) {
    if(info == null)
      _sharedPreferences.setString(VISITOR_INFO, null);
    else
      _sharedPreferences.setString(VISITOR_INFO, json.encode(info.toJson()));

  }

  static const USER = 'user';
  static const TOKEN = 'token';
  static const PASSWORD = 'password';
  static const EMAIL = 'email';
  static const VISITOR_INFO = 'vistor_info';
}
