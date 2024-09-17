import 'package:firesafe_vnex/app/main/profile/profile.state.dart';
import 'package:firesafe_vnex/repository/user.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState>  with BaseCubit{
  ProfileCubit(this._userRepository) : super(const ProfileLoadingState()) {
    load();
  }

  final UserRepository _userRepository;

  Future<void> load() async {
    try {
      safeEmit(const ProfileLoadingState());
      final userdata = await _userRepository.getUserData();
      safeEmit(ProfileLoadedState(userdata));
    } on RequestException catch (e) {
      safeEmit(ProfileErrorState(e.message));
    }
  }
}
