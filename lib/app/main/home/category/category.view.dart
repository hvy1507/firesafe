import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/app/main/home/product.item.dart';
import 'package:firesafe_vnex/components/widgets/empty_widget.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/resources/resources.dart';
import '../../../../../models/product/product.short.model.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../components/widgets/image.dart';
import 'category.cubit.dart';
import 'category.state.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryCubit get cubit => getCubit();

  List<ProductShortModel> searchResult = [];

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
      body: BlocBuilder<CategoryCubit,CategoryState>(
        builder: (context, state) {
          if (state is CategoryError) {
            return buildEmpty();
          }
          if (state is CategoryLoading && state.page == 1) {
            return buildLoading();
          }
          if (state is CategorySuccess) {
            if (state.page == 1) {
              searchResult
                ..clear()
                ..addAll(state.products);
            } else {
              searchResult.addAll(state.products);
            }
          }
          if (searchResult.isEmpty) {
            return buildEmpty();
          } else {
            return buildResult(
              searchResult,
              addSkeleton: state is CategoryLoading && state.page != 1,
            );
          }
        },
      ),
    );
  }

  Widget buildError() {
    return const FSErrorWidget();
  }

  Widget buildLoading() {
    return const Center(
      child: FSProgressIndicator(
        size: 60,
      ),
    );
  }

  Widget buildEmpty() {
    return const EmptyWidget(message: 'Chưa có sản phẩm nào',);
  }

  AppBar buildAppBar() {
    return AppBar(
      title: FSTextField(
        hint: R.string.searchScreen.searchHint.tr(),
        prefix: FSImage.asset(imageResource: R.image.vector.searchOutlined),
        suffix: FSImage.asset(imageResource: R.image.vector.filterOutlined),
        textInputAction: TextInputAction.search,
        onSuffixTap: () {
          // context.pushNamed(routes.filter).then((value) {
          //   cubit.searchOption = value as SearchOption;
          //   _load();
          // });
        },
        onChanged: (value) {
          // cubit.query = value;
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
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        itemCount: products.length + (addSkeleton ? 2 : 0),
        itemBuilder: (context, index) {
          if (addSkeleton && index >= products.length) {
            return ProductItem.skeleton();
          }
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
