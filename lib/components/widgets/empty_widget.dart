import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FSImage.asset(
            imageResource: R.image.vector.empty,
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            message ?? 'Không tìm thấy dữ liệu',
            style: context.bodyM.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
