import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/components/widgets/empty_widget.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/resources/resources.dart';
import '../../../../../models/product/product.short.model.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../components/widgets/image.dart';
import '../product.item.dart';
import 'search.cubit.dart';
import 'search.state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchCubit get cubit => getCubit();

  List<ProductShortModel> searchResult = [];
  late Future<List<String>> historySearch;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.loadState == LoadState.idle) {
            return const SizedBox.shrink();
          }
          if (state.loadState == LoadState.error) {
            return FSErrorWidget(
              retry: () {
                _load();
              },
            );
          }
          if (state.loadState == LoadState.loading) {
            return buildLoading();
          }
          if (state.loadState == LoadState.loaded) {
            if (state.currentPage == 1) {
              searchResult
                ..clear()
                ..addAll(state.result);
            } else {
              searchResult.addAll(state.result);
            }
          }
          if (searchResult.isEmpty) {
            return const EmptyWidget();
          } else {
            return buildResult(
              searchResult,
              addSkeleton: state.loadState == LoadState.loading && state.currentPage != 1,
            );
          }
        },
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: FSProgressIndicator(
        size: 60,
      ),
    );
  }

  Widget buildEmpty() {
    return Center(
      child: FSImage.asset(
        imageResource: R.image.vector.notFound,
        color: R.color.mainColor,
        fit: BoxFit.cover,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: FSTextField(
        hint: R.string.searchScreen.searchHint.tr(),
        prefix: FSImage.asset(imageResource: R.image.vector.searchOutlined),
        suffix: FSImage.asset(imageResource: R.image.vector.filterOutlined),
        textInputAction: TextInputAction.search,
        onSuffixTap: () {
          context.pushNamed(routes.filter).then(
            (value) {
              cubit.searchOption = value as SearchOption?;
              _load();
            },
          );
        },
        onChanged: (value) {
          cubit.query = value;
        },
        onSubmitted: (value) {
          _load();
        },
      ),
    );
  }

  Widget buildResult(List<ProductShortModel> products, {bool addSkeleton = false}) {
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.getResult();
      },
      child: ListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: products[index],
                onTap: () {
                  context.pushNamed(
                    routes.detail,
                    pathParameters: {
                      'id': products[index].productId,
                    },
                  );
                },
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3.5 / 5,
            ),
          ),
          if (addSkeleton) const FSProgressIndicator(),
        ],
      ),
    );
  }

  void _loadMore() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      cubit.loadMore();
    }
  }

  void _load() {
    cubit.getResult();
  }
}
