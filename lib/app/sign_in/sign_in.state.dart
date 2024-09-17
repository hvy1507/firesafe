import 'package:equatable/equatable.dart';
import 'package:firesafe_vnex/models/user/user.model.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class InitialSignInState extends SignInState {
  const InitialSignInState();

  @override
  List<Object?> get props => [];
}

class SigningInState extends SignInState {
  const SigningInState(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignedInState extends SignInState {
  const SignedInState();

  @override
  List<Object?> get props => [];
}

class SignInError extends SignInState {
  const SignInError({this.message, this.invalidEmail = false});

  final String? message;
  final bool invalidEmail;

  @override
  List<Object?> get props => [message];
}
