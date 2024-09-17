import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/resources/resources.dart';
import '../../../../../components/commons/product_categories.dart';
import '../../../../../components/widgets/image.dart';
import '../search.cubit.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  TextEditingController year = TextEditingController();
  SearchOptionBuilder optionBuilder = SearchOption.builder();

  void reset() {
    setState(() {
      selectedIndexes = [];
      yearValidation = true;
      minPrice.clear();
      maxPrice.clear();
      year.clear();
    });
  }

  bool yearValidation = true;
  List selectedIndexes = [];
  PriceType? priceType = PriceType.fixed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildFilterButton(),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          buildProductType(),
          ...buildPriceRange(),
          // ...buildProductYear(),
          ...buildRating(),
        ].addBetween(
          const SizedBox(
            height: 30,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        centerTitle: true,
        title: Text(
          R.string.filterScreen.filter.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  Widget buildFilterButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .1,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: Colors.white60,
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: OutlinedButton(
                onPressed: () {
                  optionBuilder.reset();
                  reset();
                },
                child: Text(R.string.filterScreen.reset.tr()),
              )),
          const Spacer(),
          Expanded(
              flex: 5,
              child: FilledButton(
                onPressed: !check(minPrice, maxPrice, selectedIndexes)
                    ? null
                    : () {
                        context.pop(optionBuilder.build());
                      },
                child:Text(R.string.filterScreen.filter.tr()),
              ))
        ],
      ),
    );
  }

  Widget buildProductType() {
    return Card(
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(),
        collapsedShape: const RoundedRectangleBorder(),
        title:  Text(
          R.string.filterScreen.productType.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: List.generate(
          8,
          (index) => CheckboxListTile(
            side: BorderSide(width: 2, color: R.color.mainColor),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
            dense: true,
            title: Text(Category.values[index].toText().tr()),
            controlAffinity: ListTileControlAffinity.leading,
            value: selectedIndexes.contains(index),
            onChanged: (bool? value) {
              setState(() {
                if (selectedIndexes.contains(index)) {
                  selectedIndexes.remove(index);
                  optionBuilder.removeCategory(Category.values[index]);
                } else {
                  selectedIndexes.add(index);
                  optionBuilder.addCategory(Category.values[index]);
                }
              });
            },
          ),
        ).toList(),
      ),
    );
  }

  List<Widget> buildPriceRange() {
    return [
      Text(
        R.string.filterScreen.priceRange.tr(),
        style: context.bodyL.copyWith(fontWeight: FontWeight.bold),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FSTextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: minPrice,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              label: R.string.filterScreen.min.tr(),
              error: () {
                if (minPrice.text.isNotEmpty) {
                  final min = int.parse(minPrice.text);
                  if (min <= 0) {
                    return R.string.filterScreen.zeroPlus.tr();
                  }
                } else {
                  return null;
                }
              }.call(),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: FSTextField(
              onChanged: (value) {
                setState(() {
                  if (minPrice.text.isNotEmpty && maxPrice.text.isNotEmpty){
                    optionBuilder.addPriceRange(int.parse(maxPrice.text), int.parse(minPrice.text));
                  }
                });
              },
              enabled: minPrice.text.isNotEmpty,
              controller: maxPrice,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              label: R.string.filterScreen.max.tr(),
              error: () {
                if (minPrice.text.isEmpty) {
                  return null;
                }
                if (maxPrice.text.isEmpty) {
                  return R.string.filterScreen.compulsory.tr();
                }
                final min = int.parse(minPrice.text);
                final max = int.parse(maxPrice.text);
                if (min >= max) {
                  return R.string.filterScreen.invalid.tr();
                }
                return null;
              }.call(),
            ),
          ),
        ],
      ),
    ];
  }
  List<Widget> buildRating() {
    return [
      Text(
        R.string.filterScreen.rating.tr(),
        style: context.bodyL.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      Center(
        child: RatingsWidget(
          onRatingChanged: (int value) {
            setState(() {
              optionBuilder.addRating(value);
            });
          },
          rating: optionBuilder.rating ?? 0,
        ),
      ),
    ];
  }

  bool check(TextEditingController min, TextEditingController max, List<dynamic> list) {
    if (list.isEmpty) {
      return false;
    }
    if (min.text.isEmpty || max.text.isEmpty) {
      return false;
    }
    if (min.text.isNotEmpty && max.text.isNotEmpty) {
      final minP = int.parse(minPrice.text);
      final maxP = int.parse(maxPrice.text);

      if (minP <= 0 || maxP < minP || maxP <= 0 || minP == maxP) {
        return false;
      }
    }
    return true;
  }
}

enum PriceType { fixed, range }

class RatingsWidget extends StatefulWidget {
  const RatingsWidget({Key? key, required this.rating, required this.onRatingChanged, this.size}) : super(key: key);
  final int rating;
  final ValueChanged<int> onRatingChanged;
  final double? size;

  @override
  _RatingsWidgetState createState() => _RatingsWidgetState();
}

class _RatingsWidgetState extends State<RatingsWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> array = [];
    for (var i = 1; i <= 5; i++) {
      array.add(IconButton(
        icon: widget.rating < i
            ? FSImage.asset(
                imageResource: R.image.vector.starOutlined,
                color: R.color.mainColor,
                width: 30,
                height: 30,
              )
            : FSImage.asset(
                width: 30,
                height: 30,
                imageResource: R.image.vector.starBold,
                color: R.color.mainColor,
              ),
        onPressed: () {
          widget.onRatingChanged(i);
        },
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: array,
    );
  }
}
