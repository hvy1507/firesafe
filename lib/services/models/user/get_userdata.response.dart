import 'package:firesafe_vnex/models/user/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_userdata.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetUserDataResponse {

  GetUserDataResponse({required this.user});
  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) => _$GetUserDataResponseFromJson(json);

  final UserModel user;

  Map<String, dynamic> toJson() => _$GetUserDataResponseToJson(this);
}