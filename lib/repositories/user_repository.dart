import 'dart:async';

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
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken');
    bool hasToken = false;
//    hasToken = (accessToken == null ? false : true);
    if(accessToken == null) {
      hasToken = false;
    }else{
      hasToken = true;
    }
    return hasToken;
  }

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

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    String getName = prefs.getString('name');
    return getName;
  }
}
