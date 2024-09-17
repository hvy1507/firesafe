import 'package:json_annotation/json_annotation.dart';

part 'newspaper.short.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class NewspaperShortModel {
  NewspaperShortModel({required this.newspaperId, required this.title, required this.thumbnail, required this.createdAt, required this.editedAt});

  factory NewspaperShortModel.fromJson(Map<String, dynamic> json) => _$NewspaperShortModelFromJson(json);
  final String newspaperId;
  final String title;
  final String thumbnail;
  final DateTime createdAt;
  final DateTime editedAt;

  Map<String, dynamic> toJson() => _$NewspaperShortModelToJson(this);
}
