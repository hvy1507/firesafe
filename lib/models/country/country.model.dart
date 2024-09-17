import 'package:json_annotation/json_annotation.dart';

part 'country.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class CountryModel {
  CountryModel({
    required this.id,
    required this.name,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);

  final String id;
  final String name;

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
