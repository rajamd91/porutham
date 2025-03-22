import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:poruththam_app/features/authentication/controllers/login/login_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/family_detail_controller.dart';
import '../religion/add_new_religious_details.dart';

class AddNewFamilyDetailScreen extends StatelessWidget {
  const AddNewFamilyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FamilyController());
    final loginController = Get.put(LoginController());

    return Scaffold(
      appBar:
          const TAppBar(showBackArrow: true, title: Text('Add Family Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.familyDetailsFormKey,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        () {
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: controller.familyType.value,
                            items: controller.familyTypeList
                                .map((status) => DropdownMenuItem(
                                      value: status,
                                      child: Text(status),
                                    ))
                                .toList(),
                            onChanged: controller.updateFamilyType,
                            decoration:
                                const InputDecoration(labelText: 'Family Type'),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Obx(
                        () {
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: controller.familyStatus.value,
                            items: controller.familyStatusList
                                .map((status) => DropdownMenuItem(
                                      value: status,
                                      child: Text(status),
                                    ))
                                .toList(),
                            onChanged: controller.updateFamilyStatus,
                            decoration: const InputDecoration(
                                labelText: 'Family Status'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.fatherOccupation,
                          validator: (value) => TValidator.validateEmptyText(
                              'Father Occupation', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.user,
                              ),
                              labelText: 'Father Occupation')),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: TextFormField(
                          controller: controller.motherOccupation,
                          validator: (value) => TValidator.validateEmptyText(
                              'Mother Occupation', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.user,
                              ),
                              labelText: 'Mother Occupation')),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    controller: controller.familyOrigin,
                    validator: (value) =>
                        TValidator.validateEmptyText('Family Origin', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Family Origin')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(() => DropdownButtonFormField<int>(
                      value: controller.noOfBrothers.value,
                      onChanged: (int? newValue) {
                        controller.setSelectedBrothersValue(newValue!);
                      },
                      items: List.generate(7, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text('$index'),
                        );
                      }),
                      decoration: const InputDecoration(
                        labelText: 'Total Brothers',
                        border: OutlineInputBorder(),
                      ),
                    )),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(() => DropdownButtonFormField<int>(
                      value: controller.brothersMarried.value,
                      onChanged: (int? newValue) {
                        controller.setSelectedMarriedBrothersValue(newValue!);
                      },
                      items: List.generate(controller.noOfBrothers.value + 1,
                          (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text('$index'),
                        );
                      }),
                      decoration: const InputDecoration(
                        labelText: 'Brothers Married',
                        border: OutlineInputBorder(),
                      ),
                    )),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(() => DropdownButtonFormField<int>(
                      value: controller.noOfSisters.value,
                      onChanged: (int? newValue) {
                        controller.setSelectedSistersValue(newValue!);
                      },
                      items: List.generate(7, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text('$index'),
                        );
                      }),
                      decoration: const InputDecoration(
                        labelText: 'Total Sisters',
                        border: OutlineInputBorder(),
                      ),
                    )),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () => DropdownButtonFormField<int>(
                    value: controller.sistersMarried.value,
                    onChanged: (int? newValue) {
                      controller.setSelectedMarriedSistersValue(newValue!);
                    },
                    items: List.generate(controller.noOfSisters.value + 1,
                        (index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text('$index'),
                      );
                    }),
                    decoration: const InputDecoration(
                      labelText: 'Sisters Married',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewFamilyDetailsToUserCollection();
                      Get.to(() => const AddNewReligiousDetailScreen());
                    },
                    child: const Text(TTexts.submitDetails),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.put(loginController.signOut()),
                      child: const Text('Logout')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
