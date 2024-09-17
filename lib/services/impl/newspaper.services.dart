import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/services/models/newspaper/get_newspaper.response.dart';
import 'package:firesafe_vnex/services/models/newspaper/get_newspaper.short.response.dart';

import '../endpoints.dart';

class NewspaperService extends BaseService {
  Future<GetNewspaperShortResponse> getAllNews() async {
    return GetNewspaperShortResponse.fromJson((await getResult(endpoints.newspaper.getAll, requestType: RequestType.GET, query: {}))!);
  }

  Future<GetNewspaperShortResponse> getNewNews() async {
    return GetNewspaperShortResponse.fromJson((await getResult(endpoints.newspaper.getNew, requestType: RequestType.GET, query: {}))!);
  }

  Future<GetNewspaperShortResponse> getNewsByProductCategory() async {
    return GetNewspaperShortResponse.fromJson((await getResult(endpoints.newspaper.getByProductCategory, requestType: RequestType.GET, query: {}))!);
  }

  Future<GetNewspaperShortResponse> getNewsByField() async {
    return GetNewspaperShortResponse.fromJson((await getResult(endpoints.newspaper.getByField, requestType: RequestType.GET, query: {}))!);
  }

  Future<GetNewspaperResponse> getNewsDetail(String id) async {
    return GetNewspaperResponse.fromJson((await getResult(endpoints.newspaper.getDetail, requestType: RequestType.GET, query: {'id': id}))!);
  }
}
