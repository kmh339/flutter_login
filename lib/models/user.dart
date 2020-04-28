import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/user_data.dart';
import 'package:flutter_login/models/user_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class User extends Equatable {
  final UserData data;
  final UserMeta meta;

  const User({
    this.data,
    this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'User';
}