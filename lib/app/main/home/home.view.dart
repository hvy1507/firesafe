import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firesafe_vnex/components/commons/product_categories.dart';
import 'package:firesafe_vnex/components/widgets/clickable.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/static_grid.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/repository/authentication.repo.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:firesafe_vnex/utils/extensions/scope.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../components/resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.requestPermission(provisional: true).whenComplete(
      () async {
        (await FirebaseMessaging.instance.getToken())?.let(
          (it) {
            getRepo<AuthenticationRepository>().registerFCM(it);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          buildSearch(),
          buildFeatures(),
          buildCategories(),
        ].addBetween(
          const SizedBox(height: 24),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 16,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FSImage.asset(
                imageResource: R.image.vector.appLogo,
                width: 36,
                height: 36,
              ),
            ),
          ),
          Text(
            R.string.appName,
          ).tr(),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: FSImage.asset(
            imageResource: R.image.vector.notificationOutlined,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
      centerTitle: false,
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: FSTextField(
        hint: R.string.homeScreen.search.tr(),
        readOnly: true,
        canRequestFocus: false,
        prefix: FSImage.asset(imageResource: R.image.vector.searchOutlined),
        onTap: () {
          context.pushNamed(routes.search);
        },
      ),
    );
  }

  Widget buildFeatures() {
    Widget buildFeatureIcon({
      required String title,
      required String imageR,
      required Function() onTap,
    }) {
      return SizedBox(
        width: 92,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Clickable(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: R.color.secondaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: FSImage.asset(imageResource: imageR),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                      ),
                      child: Text(
                        title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: context.labelS,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      scrollDirection: Axis.horizontal,
      child: StaticGrid(
        columnSpacing: 16,
        rowSpacing: 8,
        row: 2,
        children: [
          buildFeatureIcon(
            title: R.string.homeScreen.featureNews.tr(),
            imageR: R.image.drawable.features.news,
            onTap: () {
              context.pushNamed(routes.news);
            },
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.featureAdvisory.tr(),
            imageR: R.image.drawable.features.advisory,
            onTap: () {},
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.featureMarketReport.tr(),
            imageR: R.image.drawable.features.market,
            onTap: () {},
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.featureProjectInfo.tr(),
            imageR: R.image.drawable.features.projectInfo,
            onTap: () {},
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.featureLaws.tr(),
            imageR: R.image.drawable.features.laws,
            onTap: () {},
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.featureCompare.tr(),
            imageR: R.image.drawable.features.compare,
            onTap: () {},
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.community.tr(),
            imageR: R.image.drawable.features.community,
            onTap: () {},
          ),
          buildFeatureIcon(
            title: R.string.homeScreen.favourite.tr(),
            imageR: R.image.drawable.features.favorite,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildCategories() {
    Widget buildCategoryTile(
      Category c, {
      required Function() onTap,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Card(
          child: Clickable(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: R.color.secondaryColor,
                    ),
                    child: FSImage.asset(
                      imageResource: c.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      c.toText(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleM.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Text(
            R.string.homeScreen.productCategory,
            style: context.titleM.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
        ),
        ...Category.values
            .map((c) {
              return buildCategoryTile(
                c,
                onTap: () {
                  context.pushNamed(
                    routes.category,
                    pathParameters: {
                      'id': c.toString(),
                    },
                  );
                },
              );
            })
            .toList()
            .addBetween(
              const SizedBox(height: 8),
            ),
      ],
    );
  }
}

class _HomeSuggestions extends StatefulWidget {
  const _HomeSuggestions();

  @override
  State<_HomeSuggestions> createState() => _HomeSuggestionsState();
}

class _HomeSuggestionsState extends State<_HomeSuggestions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            R.string.homeScreen.featured,
            style: context.titleM.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
        ),
      ],
    );
  }
}
