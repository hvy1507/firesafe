import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_newspaper.short.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetNewspaperShortResponse {
  GetNewspaperShortResponse({required this.newspapers});

  factory GetNewspaperShortResponse.fromJson(Map<String, dynamic> json) => _$GetNewspaperShortResponseFromJson(json);

  final List<NewspaperShortModel> newspapers;

  Map<String, dynamic> toJson() => _$GetNewspaperShortResponseToJson(this);
}
