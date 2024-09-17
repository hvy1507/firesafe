// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firesafe_vnex/utils/logger.dart';
//
// class FCMServices {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   Future initialize() async {
//     await requestPermission();
//     final token = await getToken();
//     debugLog('FCM Token = $token');
//   }
//
//   Future<NotificationSettings> requestPermission() async {
//     final NotificationSettings settings = await _fcm.requestPermission(
//       provisional: true
//     );
//     return settings;
//   }
//
//   Future<String?> getToken() async {
//     final String? token = await _fcm.getToken();
//     return token;
//   }
// }
