import 'package:firebase_auth/firebase_auth.dart';
import 'package:firesafe_vnex/models/user/user.model.dart';
import 'package:firesafe_vnex/repository/authentication.repo.dart';
import 'package:firesafe_vnex/services/impl/authentication.service.dart';
import 'package:firesafe_vnex/utils/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _authService = AuthenticationService();
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  bool isUserSignedIn() {
    FirebaseAuth.instance.currentUser?.getIdToken();
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    final fAuthResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if (fAuthResult.user != null) {
      await _authService.signIn();
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await _authService.signUp();
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> registerFCM(String token) async {
    await _authService.fcmRegister(token);
  }

  @override
  Future<void> unregisterFCM(String token) async {
    await _authService.fcmUnregister(token);
  }

  @override
  Future<({bool isSignedIn, bool isNew})> authenticateViaGoogle() async {
    final result = await _googleSignIn.signIn();
    if (result != null) {
      try {
        await _authService.signIn();
        return (isSignedIn: true, isNew: false);
      } catch (e) {
        return (isSignedIn: true, isNew: true);
      }
    } else {
      return (
        isSignedIn: false,
        isNew: false,
      );
    }
  }
}
