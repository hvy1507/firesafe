import 'package:firesafe_vnex/models/user/user.model.dart';

abstract class UserRepository {
  Future<List<String>> getAllRoles();

  Future<void> setRoles(List<String> roles);

  Future<UserModel> getUserData();
}