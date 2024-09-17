import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/services/endpoints.dart';
import 'package:firesafe_vnex/services/models/country/get_country.response.dart';

class CountryService extends BaseService {
  Future<GetCountryResponse> getAllCountry () async {
    return GetCountryResponse.fromJson((await getResult(endpoints.country.get, requestType: RequestType.GET, query: {}))!);
  }
}