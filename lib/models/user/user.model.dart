import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UserModel {
  UserModel({required this.userId, this.roles = const [], this.name, this.avatar, this.banner});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  final String userId;
  final String? name;
  final String? avatar;
  final String? banner;
  final List<String> roles;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
