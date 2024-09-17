import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/clickable.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/models/product/product.short.model.dart';
import 'package:firesafe_vnex/utils/extensions/fortmat.ext.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../components/widgets/image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, this.onTap});

  final ProductShortModel product;
  final Function()? onTap;

  static Widget skeleton() {
    Widget shimmerBox({double? width, double? height, double radius = 8}) {
      return Shimmer.fromColors(
        baseColor: R.color.secondaryColor,
        highlightColor: R.color.mainColor,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 60,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: shimmerBox(radius: 20),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: shimmerBox(
                  width: 128,
                  height: 18,
                ),
              ),
            ),
            shimmerBox(
              width: 64,
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 60,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
        borderRadius: BorderRadius.circular(28),
      ),
      child: Clickable(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FSImage.network(
                    imageUrl: product.thumbnail,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.name,
                    style: context.titleM.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                product.price != null
                    ? '${product.price.formatCurrency()}đ'
                    : product.priceMax == null
                        ? 'Từ ${product.priceMin.formatCurrency()}'
                        : '${product.priceMin.formatCurrency()} - ${product.priceMax.formatCurrency()}',
                style: context.labelL.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
