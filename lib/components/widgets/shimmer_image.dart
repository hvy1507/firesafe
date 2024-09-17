import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/resources.dart';

class ImageShimmer extends StatelessWidget {
  final String url;
  final double? height, width;

  const ImageShimmer({Key? key, required this.url, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, o, s) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).primaryColor,
              ),
              const Text('Error!')
            ],
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Shimmer.fromColors(
            baseColor: R.color.mainColor,
            highlightColor: R.color.secondaryColor,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
