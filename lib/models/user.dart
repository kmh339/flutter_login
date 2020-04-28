import 'package:flutter_login/models/user_data.dart';
import 'package:flutter_login/models/user_meta.dart';

class User {
  UserData data;
  UserMeta meta;

  User({this.data, this.meta});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['meta'] = this.meta;
    return data;
  }}
