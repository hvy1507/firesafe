import 'package:firesafe_vnex/services/base_services.dart';

import '../endpoints.dart';
import '../models/role/get_all_roles.response.dart';

class RoleService extends BaseService {
  Future<GetAllRolesResponse> getAvailableRoles() async {
    return GetAllRolesResponse.fromJson((await getResult(
      endpoints.role.available,
      requestType: RequestType.GET,
    ))!);
  }

  Future<void> setRoles(List<String> roles) async {
    await getResult(
      endpoints.role.set,
      requestType: RequestType.POST,
      formData: {'roles': roles},
    );
  }
}
