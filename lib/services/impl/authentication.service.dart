import 'package:firesafe_vnex/services/base_services.dart';

import '../endpoints.dart';

class AuthenticationService extends BaseService {
  Future<void> signIn() async {
    await getResult(
      endpoints.authentication.signIn,
      requestType: RequestType.GET,
    );
  }

  Future<void> signUp() async {
    await getResult(
      endpoints.authentication.signUp,
      requestType: RequestType.POST,
    );
  }

  Future<void> fcmRegister(String token) async {
    await getResult(
      endpoints.authentication.fcmRegister,
      requestType: RequestType.POST,
      body: {
        'token': token,
      },
    );
  }

  Future<void> fcmUnregister(String token) async {
    await getResult(
      endpoints.authentication.fcmUnregister,
      requestType: RequestType.DELETE,
      body: {
        'token': token,
      },
    );
  }
}
