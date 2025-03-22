import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/features/personalization/controllers/profession_controller.dart';
import 'package:poruththam_app/features/personalization/models/profession_model.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class TSingleProfession extends StatelessWidget {
  const TSingleProfession({
    super.key,
    required this.profession,
    //required this.onTap,
  });

  final ProfessionDetailModel profession;
  //final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = ProfessionController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    // return Obx(() {
    //   final selectedAddressId = controller.selectedAddress.value.id;
    //   final selectedAddress = selectedAddressId == profession.id;
    return InkWell(
      onTap: () {},
      child: TRoundedContainer(
        width: double.infinity,
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: TColors.primary.withOpacity(0.5),
        borderColor: TColors.grey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Stack(
          children: [
            const Positioned(
              right: 5,
              top: 0,
              child: Icon(
                Iconsax.tick_circle5,
                color: TColors.dark,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profession.education,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: TSizes.sm / 2),
                Text(profession.educationDetail,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: TSizes.sm / 2),
                Text(profession.employedIn,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: TSizes.sm / 2),
                Text(profession.occupation,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: TSizes.sm / 2),
                Text(profession.occupationDetail,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: TSizes.sm / 2),
                Text(profession.income,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
