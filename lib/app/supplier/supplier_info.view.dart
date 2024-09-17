import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/app/main/home/product.item.dart';
import 'package:firesafe_vnex/app/supplier/supplier_info.cubit.dart';
import 'package:firesafe_vnex/app/supplier/supplier_info.state.dart';
import 'package:firesafe_vnex/components/widgets/empty_widget.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/profile_header.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/date_formarter.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

import '../../components/resources/resources.dart';

class SupplierInfoScreen extends StatefulWidget {
  const SupplierInfoScreen({super.key});

  @override
  State<SupplierInfoScreen> createState() => _SupplierInfoScreenState();
}

class _SupplierInfoScreenState extends State<SupplierInfoScreen> {
  SupplierInfoCubit get cubit => getCubit();

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

  int selectedIndex = 0;
  final info = (
    tapped: FSImage.asset(
      imageResource: R.image.vector.supplierInfoFilled,
      color: R.color.mainColor,
    ),
    untapped: FSImage.asset(
      imageResource: R.image.vector.supplierInfoOutlined,
      color: Colors.grey.shade500,
    ),
  tappedColor: R.color.mainColor,
  unTappedColor: Colors.grey.shade500
  );
  final product = (
    tapped: FSImage.asset(
      imageResource: R.image.vector.productFilled,
      color: R.color.mainColor,
    ),
    untapped: FSImage.asset(
      imageResource: R.image.vector.productOutlined,
      color: Colors.grey.shade500,
    ),
    tappedColor: R.color.mainColor,
    unTappedColor: Colors.grey.shade500
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierInfoCubit, SupplierInfoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(),
          body: () {
            if (state.loadState == LoadState.loading && state.info == null) {
              return const FSProgressIndicator(
                size: 50,
              );
            } else if (state.loadState == LoadState.error) {
              return FSErrorWidget(
                message: state.error,
                retry: () {
                  getCubit<SupplierInfoCubit>().getSupplierInfo();
                },
              );
            }
            return DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ProfileHeader(
                          banner: state.info!.banner != null
                              ? FSImage.network(
                                  imageUrl: state.info!.banner!,
                                  fit: BoxFit.cover,
                                )
                              : FSImage.asset(
                                  imageResource: R.image.vector.placeHolder,
                                  fit: BoxFit.cover,
                                ),
                          avatar: state.info!.avatar != null
                              ? FSImage.network(
                                  imageUrl: state.info!.avatar!,
                                  fit: BoxFit.cover,
                                )
                              : FSImage.asset(
                                  imageResource: R.image.vector.placeHolder,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: buildName(state),),
                    SliverToBoxAdapter(
                      child: TabBar(
                        onTap: (index) {
                          setState(
                            () {
                              selectedIndex = index;
                            },
                          );
                        },
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (selectedIndex == 0) info.tapped else info.untapped,
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  R.string.supplierInfoScreen.info.tr(),
                                  style: context.bodyM.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == 0 ? info.tappedColor : info.unTappedColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (selectedIndex == 1) product.tapped else product.untapped,
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(R.string.supplierInfoScreen.products.tr(),
                                    style: context.bodyM.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 1 ? product.tappedColor : product.unTappedColor,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            R.string.supplierInfoScreen.description.tr(),
                            style: context.titleM.copyWith(fontWeight: FontWeight.bold),
                          ),
                          buildDescription(state),
                          if (state.info!.address != null) ...[
                            Text(
                              R.string.supplierInfoScreen.address.tr(),
                              style: context.titleM.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(state.info!.address!, style: context.bodyM),
                          ],
                          if (state.info!.establishedAt != null) ...[
                            Text(
                              R.string.supplierInfoScreen.establishAt.tr(),
                              style: context.titleM.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(formatDatetime(state.info!.establishedAt!), style: context.bodyM),
                          ],
                        ].addBetween(const SizedBox(
                          height: 20,
                        )),
                      ),
                    ),
                    if (state.info != null)
                      if (state.loadState == LoadState.loading && state.products.isEmpty)
                        const FSProgressIndicator(
                          size: 60,
                        )
                      else if (state.products.isEmpty && state.loadState == LoadState.loaded)
                        const EmptyWidget()
                      else
                        buildResult(
                          state.products,
                          addSkeleton: state.loadState == LoadState.loading && state.products.isNotEmpty,
                        )
                  ],
                ),
              ),
            );
          }.call(),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: FSImage.asset(imageResource: R.image.vector.sendOutlined),
        ),
        IconButton(
          onPressed: () {},
          icon: FSImage.asset(imageResource: R.image.vector.moreOutlined),
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  Widget buildBanner(SupplierInfoState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ProfileHeader(
        banner: state.info!.banner == null
            ? FSImage.asset(
                imageResource: R.image.vector.placeHolder,
                fit: BoxFit.cover,
              )
            : FSImage.network(
                imageUrl: state.info!.banner.toString(),
                fit: BoxFit.cover,
              ),
        avatar: state.info!.avatar == null
            ? FSImage.asset(
                imageResource: R.image.vector.placeHolder,
              )
            : FSImage.network(
                imageUrl: state.info!.avatar.toString(),
              ),
      ),
    );
  }

  Widget buildName(SupplierInfoState state) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          state.info!.name ?? R.string.supplierInfoScreen.noName.tr(),
          textAlign: TextAlign.center,
          style: context.headlineL.copyWith(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget buildResult(List<ProductShortModel> products, {bool addSkeleton = false}) {
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.reloadSupplierProducts();
      },
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        itemCount: products.length,
        itemBuilder: (context, index) {
          // if (addSkeleton && index >= products.length) {
          //   return ProductItem.skeleton();
          // }
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

  Widget buildDescription(SupplierInfoState state) => ReadMoreText(
        state.info!.description ?? R.string.supplierInfoScreen.noDescription.tr(),
        style: context.bodyM,
        trimMode: TrimMode.Line,
        trimCollapsedText: R.string.supplierInfoScreen.readMore.tr(),
        trimExpandedText: R.string.supplierInfoScreen.showLess.tr(),
        colorClickableText: R.color.mainColor,
        textAlign: TextAlign.justify,
      );
}
