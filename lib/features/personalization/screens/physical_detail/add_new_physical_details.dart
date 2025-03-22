import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:poruththam_app/features/personalization/controllers/physical_status_controller.dart';
import 'package:poruththam_app/features/personalization/screens/profession_detail/add_new_profession_detail.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/controllers/login/login_controller.dart';
import '../../controllers/location_detail_controller.dart';

class AddNewPhysicalDetailScreen extends StatelessWidget {
  const AddNewPhysicalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhysicalDetailController());
    final loginController = Get.put(LoginController());

    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text('Add Physical Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.physicalDetailsFormKey,
            child: Column(
              children: [
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.physicalStatus.value,
                      items: controller.physicalStatusList
                          .map((physicalStatus) => DropdownMenuItem(
                                value: physicalStatus,
                                child: Text(physicalStatus),
                              ))
                          .toList(),
                      onChanged: controller.updatePhysicalStatus,
                      decoration:
                          const InputDecoration(labelText: 'physical Status'),
                    );
                  },
                ),
                // TextFormField(
                //     controller: controller.physicalStatus,
                //     validator: (value) =>
                //         TValidator.validateEmptyText('Physical Status', value),
                //     decoration: const InputDecoration(
                //         prefixIcon: Icon(
                //           Iconsax.user,
                //         ),
                //         labelText: 'Physical Status')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.height.value,
                      items: controller.heightList
                          .map((height) => DropdownMenuItem(
                                value: height,
                                child: Text(height),
                              ))
                          .toList(),
                      onChanged: controller.updateHeight,
                      decoration: const InputDecoration(labelText: 'Height'),
                    );
                  },
                ),
                // TextFormField(
                //     controller: controller.height,
                //     validator: (value) =>
                //         TValidator.validateEmptyText('Height', value),
                //     decoration: const InputDecoration(
                //         prefixIcon: Icon(
                //           Iconsax.user,
                //         ),
                //         labelText: 'Height')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<int>(
                      value: controller.weight.value,
                      items: controller.weightList
                          .map((weight) => DropdownMenuItem(
                                value: weight,
                                child: Text('$weight kg'),
                              ))
                          .toList(),
                      onChanged: controller.updateWeight,
                      decoration:
                          const InputDecoration(labelText: 'Weight (kg)'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.color.value,
                      items: controller.colorList
                          .map((color) => DropdownMenuItem(
                                value: color,
                                child: Text(color),
                              ))
                          .toList(),
                      onChanged: controller.updateColor,
                      decoration: const InputDecoration(labelText: 'Color'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.bodyType.value,
                      items: controller.bodyTypeList
                          .map((bodyType) => DropdownMenuItem(
                                value: bodyType,
                                child: Text(bodyType),
                              ))
                          .toList(),
                      onChanged: controller.updateBodyType,
                      decoration: const InputDecoration(labelText: 'Body Type'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewPhysicalDetailsToUserCollection();
                      Get.to(() => const AddNewProfessionDetailScreen());
                    },
                    child: const Text(TTexts.submitDetails),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.put(loginController.signOut()),
                      child: const Text('Logout')),
                ),

                /// Submit Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
