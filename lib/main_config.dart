import 'package:firesafe_vnex/database/firesafe_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireSafe {
  FireSafe._();

  static late final SharedPreferences _spf;

  static Future<void> setup() async {
    _spf = await SharedPreferences.getInstance();
    FiresafeDatabase.initDatabase();
    // credential = CredentialConfig._(
    //   token: await FirebaseAuth.instance.currentUser?.getIdToken(),
    // );
  }

// static late final CredentialConfig credential;
}

// class CredentialConfig {
//   CredentialConfig._({required String? token}) {
//     this.token = token;
//   }

//   static const _spKeys = ();

//   String? _token;

//   String? get token => _token;

//   set token(String? value) {
//     _token = value;
//     if (value == null || value.trim().isEmpty) {
//       BaseService.removeToken();
//     } else {
//       BaseService.putToken(token!);
//     }
//   }
// }
