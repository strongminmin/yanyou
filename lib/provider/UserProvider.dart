import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yanyou/models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel userInfo = UserModel(userId: 0);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  UserProvider() {
    this.getUserInfoFromShare().then((user) {
      userInfo = user;
      notifyListeners();
    });
  }

  Future<UserModel> getUserInfoFromShare() async {
    // 从share中获取用户信息，没有的话创建一个id为0的UserModel，
    SharedPreferences prefs = await _prefs;
    String userJson = prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return UserModel(userId: 0);
  }

  updateUserInfo(Map<String, dynamic> json) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('user', jsonEncode(json));
    userInfo = UserModel.fromJson(json);
    notifyListeners();
  }

  logout() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove('user');
    userInfo = UserModel(userId: 0);
    notifyListeners();
  }

  setUserMessage(String key, String value) async {
    SharedPreferences prefs = await _prefs;
    switch (key) {
      case 'name':
        userInfo.userName = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'password':
        userInfo.password = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'description':
        userInfo.userDescription = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'sex':
        userInfo.userSex = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'birthday':
        userInfo.userBirthday = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'image':
        userInfo.userImage = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'school':
        userInfo.volunteerSchool = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      case 'profession':
        userInfo.volunteerProfession = value;
        Map<String, dynamic> json = userInfo.toJson();
        prefs.setString('user', jsonEncode(json));
        notifyListeners();
        return;
      default:
        return;
    }
  }
}
