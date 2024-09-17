import 'package:firesafe_vnex/models/country/country.model.dart';

abstract class CountryRepository {
  Future<List<CountryModel>> getAllCountry();
  Future<String> getById(String id);
}