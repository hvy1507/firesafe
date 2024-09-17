import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/components/widgets/clickable.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/components/widgets/zoom_dialog.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/fortmat.ext.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

import '../../../components/resources/resources.dart';
import '../../../components/widgets/image.dart';
import 'product_detail.cubit.dart';
import 'product_detail.state.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<String> images = [];
  final String countryName = '';
  int thumbnailIndex = 0;
  int imagesIndex = 0;
  PageController thumbnailController = PageController();
  ScrollController imagesController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer<ProductDetailCubit, ProductDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.loadState == LoadState.loading) {
            return const Center(
              child: FSProgressIndicator(),
            );
          }
          if (state.loadState == LoadState.error) {
            return FSErrorWidget(
              retry: () {
                getCubit<ProductDetailCubit>().getDetail();
              },
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                ...buildImages(state),
                buildTitle(state),
                buildInfo(state),
                buildTable(state),
                ...buildCertificates(state),
                const SizedBox(
                  height: 16,
                ),
                FractionallySizedBox(
                  widthFactor: 1 / 2,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    label:  FittedBox(
                        child: Text(
                      R.string.productDetailScreen.contactNow.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                ),
              ].addBetween(const SizedBox(
                height: 24,
              )),
            );
          }
        },
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        shape: const RoundedRectangleBorder(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: FSImage.asset(imageResource: R.image.vector.heartOutlined),
          ),
        ],
      );

  Widget buildDescription(ProductDetailState state) {
    return ReadMoreText(
      state.product!.shortDescription,
      style: context.bodyM,
      trimMode: TrimMode.Line,
      trimCollapsedText: R.string.productDetailScreen.readMore.tr(),
      trimExpandedText: R.string.productDetailScreen.showLess.tr(),
      colorClickableText: R.color.mainColor,
      textAlign: TextAlign.justify,
    );
  }

  List<Widget> buildImages(ProductDetailState state) {
    return [
      AspectRatio(
        aspectRatio: 1,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: thumbnailController,
          itemCount: state.combinedList.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Clickable(
                onTap: () {
                  showZoomDialog(
                    child: FSImage.network(imageUrl: state.combinedList[index]),
                    context: context,
                  );
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FSImage.network(
                    fit: BoxFit.cover,
                    imageUrl: state.combinedList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      if (state.combinedList.length > 1)
        SizedBox(
          height: 100,
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              controller: imagesController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: imagesIndex == index ? R.color.mainColor : Colors.transparent,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Clickable(
                      onTap: () {
                        setState(() {
                          imagesIndex = index;
                          thumbnailController.animateToPage(
                            imagesIndex,
                            duration: const Duration(
                              milliseconds: 100,
                            ),
                            curve: Curves.bounceIn,
                          );
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: FSImage.network(
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          imageUrl: state.combinedList[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.combinedList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 20,
                );
              },
            ),
          ),
        ),
    ];
  }

  Widget buildTitle(ProductDetailState state) => Text(
        state.product!.name,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: context.headlineL.copyWith(
          fontWeight: FontWeight.bold,
        ),
      );

  Widget buildInfo(ProductDetailState state) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                R.string.productDetailScreen.description.tr(),
                style: context.titleS.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildDescription(state),
              const Divider(),
              Text(
               R.string.productDetailScreen.price.tr(),
                style: context.titleS.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'VND',
                    style: context.bodyM.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (state.product!.price != null)
                    Text(
                      state.product!.price.formatCurrency().toString(),
                      style: context.bodyM.copyWith(
                        fontWeight: FontWeight.bold,
                        color: R.color.mainColor,
                      ),
                    )
                  else
                    Text(
                      '${state.product!.priceMin.formatCurrency()} - ${state.product!.priceMax.formatCurrency()}',
                      style: context.bodyM.copyWith(
                        fontWeight: FontWeight.bold,
                        color: R.color.mainColor,
                      ),
                    ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    R.string.productDetailScreen.providedBy.tr(),
                    style: context.bodyM.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Clickable(
                    onTap: () {
                      context.pushNamed(routes.supplierInfo, pathParameters: {
                        'id': state.supplier!.id,
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: state.supplier!.avatar == null
                              ? FSImage.asset(imageResource: R.image.vector.placeHolder)
                              : FSImage.network(imageUrl: state.supplier!.avatar!,fit: BoxFit.cover,),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.supplier!.name ?? state.supplier!.id,
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                style: context.bodyM.copyWith(fontWeight: FontWeight.bold, color: R.color.mainColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ].addBetween(const SizedBox(
                  height: 20,
                )),
              )
            ].addBetween(
              const SizedBox(
                height: 20,
              ),
            ),
          ),
        ),
      );

  Widget buildTable(ProductDetailState state) {
    return Card(
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {0: FlexColumnWidth(), 1: FlexColumnWidth(2)},
        children: [
          buildRow(R.string.productDetailScreen.origin.tr(), state.countryName!),
          buildRow(R.string.productDetailScreen.model.tr(), state.product!.model),
          buildRow(R.string.productDetailScreen.brand.tr(), state.product!.brand),
          buildRow(R.string.productDetailScreen.available.tr(), state.product!.available == true ? R.string.productDetailScreen.stillAvailable.tr() : R.string.productDetailScreen.unavailable.tr()),
          buildRow(R.string.productDetailScreen.warranty.tr(), '${state.product!.warranty} ${R.string.productDetailScreen.month.tr()}'),
          buildRow(R.string.productDetailScreen.packaging.tr(), state.product!.packaging),
          buildRow(R.string.productDetailScreen.shippingTime.tr(), '${state.product!.shippingTime} ${R.string.productDetailScreen.days.tr()}'),
          buildRow(R.string.productDetailScreen.sample.tr(), state.product!.hasSample),
          buildRow(R.string.productDetailScreen.productionRate.tr(), state.product!.productionRate),
          if (state.product!.accessories != null) buildRow(R.string.productDetailScreen.accessories.tr(), state.product!.accessories.toString()),
          if (state.product!.postSupport != null) buildRow(R.string.productDetailScreen.postSupport.tr(), state.product!.postSupport ?? ' '),
          if (state.product!.faq != null) buildRow(R.string.productDetailScreen.faq.tr(), state.product!.faq ?? ''),
          if (state.product!.shape != null) buildRow(R.string.productDetailScreen.shape.tr(), state.product!.shape ?? ''),
          if (state.product!.color != null) buildRow(R.string.productDetailScreen.color.tr(), state.product!.color ?? ''),
          if (state.product!.material != null) buildRow(R.string.productDetailScreen.material.tr(), state.product!.material ?? ''),
          if (state.product!.structure != null) buildRow(R.string.productDetailScreen.structure.tr(), state.product!.material ?? ''),
          if (state.product!.weight != null) buildRow(R.string.productDetailScreen.weight.tr(), '${state.product!.weight} kg'),
          if (state.product!.volume != null) buildRow(R.string.productDetailScreen.volume.tr(), state.product!.volume.toString()),
          if (state.product!.fireResistant != null) buildRow(R.string.productDetailScreen.fireResistant.tr(), state.product!.fireResistant!),
          if (state.product!.waterResistant != null) buildRow(R.string.productDetailScreen.waterResistant.tr(), state.product!.waterResistant ?? ''),
          if (state.product!.applications != null) buildRow(R.string.productDetailScreen.applications.tr(), state.product!.applications ?? ''),
          // buildRow('Thông số kỹ thuật bổ sung', state.product!.additionalSpecification ?? ''),
          if (state.product!.additionalSpecification != null)
            ...(jsonDecode(state.product!.additionalSpecification!) as Map).entries.map(
              (sp) {
                return buildRow(sp.key.toString(), sp.value.toString());
              },
            ),
        ],
      ),
    );
  }

  TableRow buildRow(String name, String value) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              name,
              textAlign: TextAlign.start,
              style: context.bodyM.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(value, textAlign: TextAlign.start),
          ),
        )
      ],
    );
  }

  List<Widget> buildCertificates(ProductDetailState state) {
    return [
      Text(
        'CHỨNG NHẬN SẢN PHẨM',
        style: context.titleS.copyWith(fontWeight: FontWeight.bold),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: state.product!.certificates
              .map((e) => Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Clickable(
                          onTap: () {
                            showZoomDialog(
                              context: context,
                              child: FSImage.network(imageUrl: e.image),
                            );
                          },
                          child: SizedBox(
                            width: 200,
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: FSImage.network(
                                fit: BoxFit.cover,
                                imageUrl: e.image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(e.name)
                    ],
                  ))
              .toList(),
        ),
      ),
    ];
  }
}

