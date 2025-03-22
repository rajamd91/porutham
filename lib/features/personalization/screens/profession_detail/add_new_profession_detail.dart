import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:poruththam_app/features/personalization/controllers/profession_controller.dart';
import 'package:poruththam_app/features/personalization/screens/family_detail/add_new_family_details.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/controllers/login/login_controller.dart';

class AddNewProfessionDetailScreen extends StatelessWidget {
  const AddNewProfessionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfessionController());
    final loginController = Get.put(LoginController());

    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text('Add Profession Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.professionDetailsFormKey,
            child: Column(
              children: [
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.education.value,
                      items: controller.educationList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateEducation,
                      decoration: const InputDecoration(labelText: 'Education'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    controller: controller.educationDetail,
                    validator: (value) =>
                        TValidator.validateEmptyText('Education Detail', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Education Detail')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.employedIn.value,
                      items: controller.employedInList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateEmployedIn,
                      decoration:
                          const InputDecoration(labelText: 'Employed In'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.occupation.value,
                      items: controller.occupationList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateOccupation,
                      decoration:
                          const InputDecoration(labelText: 'Occupation'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    controller: controller.occupationDetail,
                    validator: (value) => TValidator.validateEmptyText(
                        'Occupation Detail', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Occupation Detail')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.income.value,
                      items: controller.incomeRanges
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: controller.updateIncome,
                      decoration: const InputDecoration(labelText: 'Income'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewProfessionDetailsToUserCollection();
                      Get.to(() => const AddNewFamilyDetailScreen());
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
