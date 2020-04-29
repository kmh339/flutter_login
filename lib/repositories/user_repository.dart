import 'dart:async';

import 'package:flutter_login/models/user_data.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
  }

  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

//  Future<bool> hasToken() async {
//    final prefs = await SharedPreferences.getInstance();
//    String accessToken = prefs.getString('accessToken');
//    bool hasToken = false;
////    hasToken = (accessToken == null ? false : true);
//    if(accessToken == null) {
//      hasToken = false;
//    }else{
//      hasToken = true;
//    }
//    return hasToken;
//  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken');
    bool isSigned = false;
    if(accessToken == null) {
      isSigned = false;
    }else{
      isSigned = true;
    }
    return isSigned;
  }

  Future<void> persistName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  Future<void> setUserData(UserData userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', userData.name);
    prefs.setString('avatar', userData.avatar);
    prefs.setString('email', userData.email);
  }

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    String getName = prefs.getString('name');
    return getName;
  }

  Future<String> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    String getAvatar = prefs.getString('avatar');
    return getAvatar;
  }

  Future<void> deleteUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('name');
    prefs.remove('avatar');
    prefs.remove('email');
    print("]-----] userInfo Deleted [-----[");
  }


}
