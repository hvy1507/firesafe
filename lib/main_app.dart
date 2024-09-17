import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firesafe_vnex/repository/provider/repo_providers.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FireSafeApp extends StatefulWidget {
  const FireSafeApp({super.key, this.initialMessage});

  final RemoteMessage? initialMessage;

  @override
  State<FireSafeApp> createState() => _FireSafeAppState();
}

class _FireSafeAppState extends State<FireSafeApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repoProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfigs,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: FireSafeTheme.theme(),
        darkTheme: FireSafeTheme.theme(dark: true),
        themeMode: ThemeMode.light,
        builder: (context, widget) => widget!,
      ),
    );
  }
}
