
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_country.response.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class GetCountryResponse {
  GetCountryResponse({required this.countries});

  factory GetCountryResponse.fromJson(Map<String, dynamic> json) => _$GetCountryResponseFromJson(json);

  final List<CountryModel> countries;

  Map<String, dynamic> toJson() => _$GetCountryResponseToJson(this);
}
