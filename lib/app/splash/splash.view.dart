import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/repository/authentication.repo.dart';
import 'package:firesafe_vnex/repository/user.repo.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/services/base_services.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:firesafe_vnex/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../components/resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    } else {
      redirectToRoute().then((value) {
        context.goNamed(value);
      });
    }
  }

  void _handleMessage(RemoteMessage message) {
    context.pushNamed(routes.newsDetail,pathParameters: {
      'id' : message.data['newspaper']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: R.color.secondaryColor,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: R.color.secondaryColor,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: R.color.secondaryColor,
      body: Center(
        child: FSProgressIndicator(
          color: R.color.mainColor,
        ),
      ),
    );
  }

  Future<String> redirectToRoute() async {
    while (true) {
      try {
        if (getRepo<AuthenticationRepository>().isUserSignedIn()) {
          await getRepo<UserRepository>().getUserData();
          return routes.home;
        } else {
          return routes.landing;
        }
      } on RequestException catch (e) {
        debugLog(e);
        if (e.statusCode == 403) {
          return routes.landing;
        }
        Fluttertoast.showToast(msg: '${e.statusCode}: ${e.message}', toastLength: Toast.LENGTH_LONG);
      }
      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
