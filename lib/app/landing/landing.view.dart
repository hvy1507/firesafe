import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/buttons.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: buildBanner(),
          ),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildBanner() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: FSImage.asset(
              imageResource: R.image.vector.appLogo,
              width: 192,
              height: 192,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              R.string.appName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
            child: FittedBox(
              child: Text(
                R.string.landingScreen.greeting,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FilledButton(
            onPressed: () {
              context.pushNamed(routes.signIn);
            },
            child: Text(R.string.landingScreen.signIn).tr(),
          ),
          FilledButton.tonal(
            onPressed: () {
              context.pushNamed(routes.signUp);
            },
            // style: ButtonStyle(
            //   backgroundColor: MaterialStateProperty.all(
            //     R.color.secondaryColor.withOpacity(0.2)
            //   )
            // ),
            child: Text(R.string.landingScreen.signUp).tr(),
          ),
          TextButton(
            onPressed: () {},
            child: Text(R.string.landingScreen.guest).tr(),
          ),
        ].addBetween(const SizedBox(height: 8)),
      ),
    );
  }
}
