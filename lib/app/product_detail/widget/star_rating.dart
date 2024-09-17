import 'package:flutter/material.dart';

import '../../../../components/resources/resources.dart';


class StarRatingWidget extends StatelessWidget {

  const StarRatingWidget({super.key, required this.rating});
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return  Icon(
            Icons.star,
            color: R.color.mainColor,
          );
        } else {
          return  Icon(
            Icons.star_border,
            color: R.color.mainColor,
          );
        }
      }),
    );
  }
}