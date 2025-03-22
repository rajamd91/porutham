import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/products/all_products_controller.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    /// Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    return Scaffold(
      /// Appbar
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                /// Check the state of the FutureBuilder snapshot
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultipleRecordState(
                    snapshot: snapshot, loader: loader);

                /// Return appropriate widget based on snapshot state
                if (widget != null) return widget;

                /// Products found!
                final products = snapshot.data!;

                return TSortableProducts(products: products);
              }),
        ),
      ),
    );
  }
}
