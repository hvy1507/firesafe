abstract class AuthenticationRepository {
  bool isUserSignedIn();

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({required String email, required String password});

  Future<({bool isSignedIn, bool isNew})> authenticateViaGoogle();

  Future<void> signOut();

  Future<void> registerFCM(String token);

  Future<void> unregisterFCM(String token);
}
