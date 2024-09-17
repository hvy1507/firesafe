import 'package:equatable/equatable.dart';
import 'package:firesafe_vnex/models/user/user.model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();

  @override
  List<Object?> get props => [];
}

class ProfileLoadedState extends ProfileState {
  const ProfileLoadedState(this.userdata);

  final UserModel userdata;

  @override
  List<Object?> get props => [userdata];
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}
