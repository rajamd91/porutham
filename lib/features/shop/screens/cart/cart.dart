import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/shop/screens/cart/widgets/cart_items.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/products/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(
        () {
          /// Nothing found widget
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! Cart is Empty.',
            animation: TImages.cartAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),

                /// Items In Cart
                child: TCartItems(),
              ),
            );
          }
        },
      ),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () {},
                //onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(() =>
                    Text('Checkout \$${controller.totalCartPrice.value}')),
              ),
            ),
    );
  }
}
