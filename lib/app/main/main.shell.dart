import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/models/user/user.model.dart';
import 'package:firesafe_vnex/repository/user.repo.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/logger.dart';

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getRepo<UserRepository>().getUserData().then((value) {
      setState(() {
        user = value;
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    debugLog('DQH ${message.data}');
    context.pushNamed(routes.newsDetail, pathParameters: {'id': message.data['newspaper']});
  }

  bool get isSupplier => user?.roles.contains('supplier') == true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        destinations: [
          NavigationDestination(
            icon: buildNavIcon(
              label: R.string.navBar.home.tr(),
              icon: FSImage.asset(
                imageResource: currentIndex == 0 ? R.image.vector.homeFilled : R.image.vector.homeOutlined,
                color: currentIndex == 0 ? R.color.mainColor : R.color.secondaryColor,
              ),
            ),
            label: R.string.navBar.home.tr().toUpperCase(),
          ),
          NavigationDestination(
            icon: buildNavIcon(
              label: R.string.navBar.cart.tr(),
              icon: FSImage.asset(
                imageResource: currentIndex == 1 ? R.image.vector.cartFilled : R.image.vector.cartOutlined,
                color: currentIndex == 1 ? R.color.mainColor : R.color.secondaryColor,
              ),
            ),
            label: R.string.navBar.cart.tr().toUpperCase(),
          ),
          if (isSupplier)
            NavigationDestination(
              icon: buildMainNavIcon(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              label: 'ADD',
            ),
          NavigationDestination(
            icon: buildNavIcon(
              label: R.string.navBar.chat.tr(),
              icon: FSImage.asset(
                imageResource: currentIndex == (isSupplier ? 3 : 2) ? R.image.vector.chatFilled : R.image.vector.chatOutlined,
                color: currentIndex == (isSupplier ? 3 : 2) ? R.color.mainColor : R.color.secondaryColor,
              ),
            ),
            label: R.string.navBar.home.tr().toUpperCase(),
          ),
          NavigationDestination(
            icon: buildNavIcon(
              label: R.string.navBar.profile.tr(),
              icon: FSImage.asset(
                imageResource: currentIndex == (isSupplier ? 4 : 3) ? R.image.vector.profileFilled : R.image.vector.profileOutlined,
                color: currentIndex == (isSupplier ? 4 : 3) ? R.color.mainColor : R.color.secondaryColor,
              ),
            ),
            label: R.string.navBar.profile.tr().toUpperCase(),
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (index) {
          if (isSupplier) {
            switch (index) {
              case 0:
                context.goNamed(routes.home);
                break;
              case 1:
                context.goNamed(routes.cart);
                break;
              case 2:
                context.pushNamed(routes.addProduct);
                break;
              case 3:
                context.goNamed(routes.chat);
                break;
              case 4:
                context.goNamed(routes.moreScreen);
                break;
            }
            setState(() {
              if (index != 2) {
                currentIndex = index;
              }
            });
          } else {
            switch (index) {
              case 0:
                context.goNamed(routes.home);
                break;
              case 1:
                context.goNamed(routes.cart);
                break;
              case 2:
                context.goNamed(routes.chat);
                break;
              case 3:
                context.goNamed(routes.moreScreen);
                break;
            }
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      body: widget.child,
    );
  }

  Widget buildNavIcon({
    required String label,
    required Widget icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(
            label,
            style: context.labelS,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget buildMainNavIcon({required Widget icon}) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            R.color.mainColor,
            R.color.mainColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: R.color.mainColor.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(4, 8),
          ),
        ],
      ),
      child: icon,
    );
  }
}
