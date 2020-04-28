import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_meta.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class UserMeta extends Equatable {
  final String token;
  final String tokenType;
  final String expiresIn;


  const UserMeta({
    this.token,
    this.tokenType,
    this.expiresIn,

  });

  factory UserMeta.fromJson(Map<String, dynamic> json) => _$UserMetaFromJson(json);

  Map<String, dynamic> toJson() => _$UserMetaToJson(this);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'UserMeta';
}