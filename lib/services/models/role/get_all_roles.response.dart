import 'package:json_annotation/json_annotation.dart';

part 'get_all_roles.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetAllRolesResponse {
  GetAllRolesResponse({required this.roles});

  factory GetAllRolesResponse.fromJson(Map<String, dynamic> json) => _$GetAllRolesResponseFromJson(json);

  final List<String> roles;

  Map<String, dynamic> toJson() => _$GetAllRolesResponseToJson(this);
}
