import 'package:firesafe_vnex/models/user/user.model.dart';
import 'package:firesafe_vnex/repository/user.repo.dart';
import 'package:firesafe_vnex/services/impl/role.service.dart';
import 'package:firesafe_vnex/services/impl/user.service.dart';

class UserRepositoryImpl extends UserRepository {
  final _userService = UserService();
  final _roleService = RoleService();

  @override
  Future<List<String>> getAllRoles() async {
    return (await _roleService.getAvailableRoles()).roles;
  }

  @override
  Future<void> setRoles(List<String> roles) async {
    await _roleService.setRoles(roles);
  }

  @override
  Future<UserModel> getUserData() async {
    return (await _userService.getUserData()).user;
  }
}
