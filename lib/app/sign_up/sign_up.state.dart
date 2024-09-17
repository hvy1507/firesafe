import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class InitialSignUpState extends SignUpState {
  const InitialSignUpState();

  @override
  List<Object?> get props => [];
}

class SigningUpState extends SignUpState {
  const SigningUpState({required this.name, required this.email, required this.password});

  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}

class SignedUpState extends SignUpState {
  const SignedUpState();

  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  const SignUpErrorState({this.error});

  final String? error;

  @override
  List<Object?> get props => [error];
}

class EmailExistState extends SignUpState {
  const EmailExistState(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}
