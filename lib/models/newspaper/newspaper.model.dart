import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'newspaper.model.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class NewspaperModel extends NewspaperShortModel {
  NewspaperModel({
    required this.content,
    required super.newspaperId,
    required super.title,
    required super.thumbnail,
    required super.createdAt,
    required super.editedAt,
  });

  factory NewspaperModel.fromJson(Map<String, dynamic> json) => _$NewspaperModelFromJson(json);
  final String content;

  @override
  Map<String, dynamic> toJson() => _$NewspaperModelToJson(this);
}
