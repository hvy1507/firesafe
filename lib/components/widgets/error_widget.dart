import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:flutter/material.dart';

class FSErrorWidget extends StatelessWidget {
  const FSErrorWidget({super.key, this.retry, this.message});

  final String? message;
  final Function()? retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FSImage.asset(
            imageResource: R.image.vector.error,
            width: 150,
            height: 150,
          ),
          Text(
            'Đã xảy ra lỗi , vui lòng thử lại',
            style: context.bodyL.copyWith(fontWeight: FontWeight.w500),
          ),
          if (message != null)
            Text(
              message!,
              style: context.bodyL.copyWith(color: Colors.grey.shade500),
            ),
          FilledButton(
            onPressed: retry,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh),
                SizedBox(
                  width: 10,
                ),
                Text('Thử lại'),
              ],
            ),
          ),
        ].addBetween(const SizedBox(
          height: 30,
        )),
      ),
    );
  }
}
