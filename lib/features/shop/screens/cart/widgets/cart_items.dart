import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/products/cart_controller.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              /// Cart Item
              TCartItem(cartItem: item),
              if (showAddRemoveButtons)
                const SizedBox(height: TSizes.spaceBtwItems),

              /// Add Remove Button Row with total price
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Extra Space
                        const SizedBox(width: 70),

                        /// Add remove Buttons
                        TProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),

                    /// Product Total Price
                    TProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1)),
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
