import 'package:firebase_auth/firebase_auth.dart';
import 'package:firesafe_vnex/repository/authentication.repo.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'sign_up.state.dart';

enum PasswordValidation {
  length,
  character,
  specialCharacter,
}

class SignUpCubit extends Cubit<SignUpState> with BaseCubit{
  SignUpCubit(this._auth) : super(const InitialSignUpState());

  final AuthenticationRepository _auth;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    safeEmit(SigningUpState(name: name, email: email, password: password));
    try {
      await _auth.signUp(email: email, password: password);
      safeEmit(const SignedUpState());
    } on FirebaseAuthException {
      safeEmit(EmailExistState(email));
    } on RequestException catch (e) {
      safeEmit(SignUpErrorState(error: e.message));
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      final result = await _auth.authenticateViaGoogle();
      if (result.isSignedIn) {
        safeEmit(const SignedUpState());
      }
    } catch (_) {
      safeEmit(SignUpErrorState(error: _.toString()));
    }
  }

  bool validName(String name) {
    // if (name.trim().isEmpty) {
    //   return false;
    // }
    return true;
  }

  bool validEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Set<PasswordValidation> validPassword(String password) {
    final result = <PasswordValidation>{};
    if (password.length < 8) {
      result.add(PasswordValidation.length);
    }
    if (!password.contains(RegExp('[a-z]')) || !password.contains(RegExp('[A-Z]'))) {
      result.add(PasswordValidation.character);
    }
    if (!password.contains(RegExp('[0-9]')) || !password.contains(RegExp(r'[,.!@#$%&*\-_]'))) {
      result.add(PasswordValidation.specialCharacter);
    }
    return result;
  }
}
