import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/commons/product_categories.dart';
import '../../../../../components/resources/resources.dart';
import '../../../../../routes/app_routes.dart';
import '../product.item.dart';
import 'product_type.cubit.dart';
import 'product_type.state.dart';

class ProductTypeScreen extends StatelessWidget {
  const ProductTypeScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Category.parse(name).toText().tr(),
          style: TextStyle(fontSize: 20, color: R.color.mainColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<ProductTypeCubit, ProductTypeState>(
        builder: (context, state) {
          if (state is ProductTypeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductTypeError) {
            return Center(
              child: Text(state.message ?? ''),
            );
          }
          return GridView.count(
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 7 / 8,
            crossAxisCount: 2,
            children: (state as ProductTypeSuccess)
                .products
                .map(
                  (e) => ProductItem(
                    product: e,
                    onTap: () {
                      context.pushNamed(
                        routes.detail,
                        pathParameters: {
                          'id': e.productId,
                        },
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
