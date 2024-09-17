import 'package:firesafe_vnex/models/newspaper/newspaper.model.dart';
import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_newspaper.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetNewspaperResponse {
  GetNewspaperResponse({required this.newspaper});

  factory GetNewspaperResponse.fromJson(Map<String, dynamic> json) => _$GetNewspaperResponseFromJson(json);

  final NewspaperModel newspaper;

  Map<String, dynamic> toJson() => _$GetNewspaperResponseToJson(this);
}
