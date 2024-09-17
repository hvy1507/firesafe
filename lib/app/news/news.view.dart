import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/app/news/news.cubit.dart';
import 'package:firesafe_vnex/app/news/news.state.dart';
import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/clickable.dart';
import 'package:firesafe_vnex/components/widgets/empty_widget.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/models/newspaper/newspaper.short.model.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:firesafe_vnex/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<String> type = [
    R.string.newsScreen.all.tr(),
    R.string.newsScreen.fields.tr(),
    R.string.newsScreen.products.tr(),
  ];
  int selectedIndex = 0;
  List<NewspaperShortModel> newNews = [];
  List<NewspaperShortModel> allNews = [];
  List<NewspaperShortModel> categoryNews = [];
  List<NewspaperShortModel> fieldNews = [];

  List<NewspaperShortModel> filter(int index) {
    switch (index) {
      case 0:
        return allNews;
      case 1:
        return categoryNews;
      case 2:
        return fieldNews;
      default:
        return allNews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsSuccess) {
            switch (state.type) {
              case NewspaperType.all:
                allNews = state.newspaper;
              case NewspaperType.news:
                newNews = state.newspaper;
              case NewspaperType.category:
                categoryNews = state.newspaper;
              case NewspaperType.field:
                fieldNews = state.newspaper;
              case NewspaperType.initial:
                return;
            }
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              buildNewNews(),
              buildChip(),
              if (state is NewsSuccess) ...buildList(filter(selectedIndex)) else buildListLoading(10),
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text(R.string.newsScreen.newspaper).tr(),
      );

  Widget buildNewNews() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: Text(
              R.string.newsScreen.news.tr(),
              style: context.titleL.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<NewsCubit, NewsState>(
            builder: (BuildContext context, NewsState state) {
              if (state is NewsError) {
                return FSErrorWidget(message: state.message, retry: () {
                  getCubit<NewsCubit>().loadAll();
                },);
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: state is NewsLoading
                      ? Row(
                          children: List.generate(
                            10,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: NewsCard.skeleton(),
                            ),
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: allNews
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: NewsCard(e: e),
                                  ))
                              .toList(),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildChip() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: Text(
              R.string.newsScreen.recent.tr(),
              style: context.titleL.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: List.generate(
                  type.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                      selected: selectedIndex == index,
                      label: Text(
                        type[index],
                        style: context.bodyM.copyWith(color: selectedIndex == index ? Colors.white : Colors.black),
                      ),
                      onSelected: (value) {
                        setState(() {
                          selectedIndex = index;
                        });
                          },
                        ),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildList(List<NewspaperShortModel> list) {
    if (list.isEmpty) {
      return [
        const SizedBox(
          height: 30,
        ),
        const EmptyWidget()
      ];
    } else {
      return list.map((e) => buildNewsItem(e)).toList();
    }
  }

  Widget buildListLoading(int item) {
    return Shimmer.fromColors(
      baseColor: R.color.secondaryColor,
      highlightColor: R.color.mainColor,
      child: Column(
        children: List.generate(
          item,
              (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 8),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 14,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.only(right: 10),
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        height: 14,
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  Widget buildNewsItem(NewspaperShortModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Clickable(
        onTap: () {
          context.pushNamed(routes.newsDetail, pathParameters: {'id': model.newspaperId});
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 8),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyL.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                () {
                                  final time = timeAgo(model.createdAt);
                                  if (time.days > 0) {
                                    return R.string.newsScreen.daysAgo.tr(args: [time.days.toString()]);
                                  }
                                  if (time.hours > 0) {
                                    return R.string.newsScreen.hoursAgo.tr(args: [time.hours.toString()]);
                                  }
                                  return R.string.newsScreen.minutesAgo.tr(args: [time.minutes.toString()]);
                                }.call(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.labelS.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: FSImage.network(
                            imageUrl: model.thumbnail,fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.e});

  final NewspaperShortModel e;

  static Widget skeleton() {
    return Shimmer.fromColors(
      baseColor: R.color.secondaryColor,
      highlightColor: R.color.mainColor,
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Flexible(
              child: Container(
                height: 14,
                width: 128,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Flexible(
              child: Container(
                height: 14,
                width: 128,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Clickable(
        onTap: () {
          context.pushNamed(routes.newsDetail, pathParameters: {'id': e.newspaperId});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FSImage.network(
                  imageUrl: e.thumbnail,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, event) {
                    if (event == null) {
                      return child;
                    }
                    return Shimmer.fromColors(
                        highlightColor: R.color.mainColor,
                        baseColor: R.color.secondaryColor,
                        child: const SizedBox(
                          width: 100,
                          height: 100,
                        ));
                  },
                ),
              ),
            ),
            Flexible(
              child: Text(
                e.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.bodyM.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Text(
                () {
                  final time = timeAgo(e.createdAt);
                  if (time.days > 0) {
                    return R.string.newsScreen.daysAgo.tr(args: [time.days.toString()]);
                  }
                  if (time.hours > 0) {
                    return R.string.newsScreen.hoursAgo.tr(args: [time.hours.toString()]);
                  }
                  return R.string.newsScreen.minutesAgo.tr(args: [time.minutes.toString()]);
                }.call(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.bodyM.copyWith(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 10),
              ),
            ),
          ].addBetween(
            const SizedBox(
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}

({int days, int hours, int minutes}) timeAgo(DateTime time) {
  final now = DateTime.now().toUtc();
  final difference = now.difference(time);
  final result = (
    minutes: difference.inMinutes % (24 * 60),
    hours: difference.inHours % 24,
    days: difference.inDays,
  );
  debugLog(result);
  return result;
}
