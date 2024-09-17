import 'package:dio/dio.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/services/endpoints.dart';

import '../models/user/get_userdata.response.dart';

class UserService extends BaseService {
  Future<void> editProfile({
    String? name,
    MultipartFile? avatar,
    MultipartFile? banner,
  }) async {
    await getResult(
      endpoints.user.edit,
      requestType: RequestType.POST,
      formData: {
        'name': name,
        'avatar': avatar,
        'banner': banner,
      },
    );
  }

  Future<GetUserDataResponse> getUserData() async {
    return GetUserDataResponse.fromJson((await getResult(
      endpoints.user.getUserData,
      requestType: RequestType.GET,
    ))!);
  }
}
