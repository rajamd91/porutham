import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:poruththam_app/features/personalization/controllers/religious_controller.dart';
import 'package:poruththam_app/features/personalization/screens/location/add_new_location_details.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/controllers/login/login_controller.dart';

class AddNewReligiousDetailScreen extends StatelessWidget {
  const AddNewReligiousDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReligiousController());
    final loginController = Get.put(LoginController());
    controller.religion.text = 'Muslim';

    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text('Add Religious Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.religiousDetailsFormKey,
            child: Column(
              children: [
                TextFormField(
                    readOnly: true,
                    controller: controller.religion,
                    validator: (value) =>
                        TValidator.validateEmptyText('Religion', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Religion')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.madhab.value,
                      items: controller.madhabList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateMadhab,
                      decoration: const InputDecoration(labelText: 'Madhab'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.division.value,
                      items: controller.divisionList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateDivision,
                      decoration: const InputDecoration(labelText: 'Division'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-z A-Z á-ú Á-Ú]')),
                    ],
                    controller: controller.jamath,
                    validator: (value) =>
                        TValidator.validateEmptyText('Jamath', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Jamath')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.follows.value,
                      items: controller.followsList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateFollows,
                      decoration: const InputDecoration(labelText: 'Follows'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.religiousValues.value,
                      items: controller.religiousValuesList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateReligiousValues,
                      decoration:
                          const InputDecoration(labelText: 'ReligiousValues'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewReligiousDetailsToUserCollection();
                      Get.to(() => const AddNewLocationDetailScreen());
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

                /// Submit Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
