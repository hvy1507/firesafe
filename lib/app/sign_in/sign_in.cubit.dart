import 'package:firesafe_vnex/repository/authentication.repo.dart';
import 'package:firesafe_vnex/utils/extensions/cubit.ext.dart';
import 'package:firesafe_vnex/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'sign_in.state.dart';

class SignInCubit extends Cubit<SignInState> with BaseCubit {
  SignInCubit(this._auth) : super(const InitialSignInState());

  final AuthenticationRepository _auth;

  Future<void> signIn(String email, String password) async {
    safeEmit(SigningInState(email, password));
    try {
      await _auth.signIn(email: email, password: password);
      safeEmit(const SignedInState());
    } on Exception catch (e) {
      errorLog(e);
      safeEmit(SignInError(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final result = await _auth.authenticateViaGoogle();
      if (result.isSignedIn) {
        safeEmit(const SignedInState());
      }
    } catch (_) {
      safeEmit(SignInError(message: _.toString()));
    }
  }
}
