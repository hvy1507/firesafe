import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firesafe_vnex/main_app.dart';
import 'package:firesafe_vnex/main_config.dart';
import 'package:firesafe_vnex/services/fcm_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireSafe.setup();
  await EasyLocalization.ensureInitialized();
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('vi', 'VN'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('vi', 'VN'),
    child: FireSafeApp(
      initialMessage: initialMessage,
    ),
  ));
}
