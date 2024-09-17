// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newspaper.short.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewspaperShortModel _$NewspaperShortModelFromJson(Map<String, dynamic> json) =>
    NewspaperShortModel(
      newspaperId: json['newspaperId'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      editedAt: DateTime.parse(json['editedAt'] as String),
    );

Map<String, dynamic> _$NewspaperShortModelToJson(
        NewspaperShortModel instance) =>
    <String, dynamic>{
      'newspaperId': instance.newspaperId,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'createdAt': instance.createdAt.toIso8601String(),
      'editedAt': instance.editedAt.toIso8601String(),
    };
