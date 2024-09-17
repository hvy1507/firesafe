import 'package:firesafe_vnex/database/firesafe_database.dart';
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:firesafe_vnex/repository/country.repo.dart';
import 'package:firesafe_vnex/services/impl/country.service.dart';
import 'package:firesafe_vnex/utils/logger.dart';

class CountryRepositoryImpl extends CountryRepository {
  final CountryService _countryService = CountryService();
  final List<CountryModel> countries = [];


  @override
  Future<List<CountryModel>> getAllCountry() async {
    if (countries.isEmpty) {
      final persisted = await FiresafeDatabase.countryDao.getAll();
      if (persisted.isNotEmpty) {
        countries.addAll(persisted);
      } else {
        final network = (await _countryService.getAllCountry()).countries;
        countries.addAll(network);
        FiresafeDatabase.countryDao.addAll(countries);
      }
    }
    return countries;
  }

  @override
  Future<String> getById(String id) async {
    final countries = await getAllCountry();
    return countries.firstWhere((element) => element.id == id).name;
  }
}
