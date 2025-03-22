import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:poruththam_app/features/personalization/screens/profile/resume_screen.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/controllers/login/login_controller.dart';
import '../../controllers/location_detail_controller.dart';

class AddNewLocationDetailScreen extends StatelessWidget {
  const AddNewLocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationController());
    final loginController = Get.put(LoginController());
    controller.country.text = 'India';

    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text('Add Location Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.locationDetailsFormKey,
            child: Column(
              children: [
                TextFormField(
                    readOnly: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-z A-Z á-ú Á-Ú]')),
                    ],
                    controller: controller.country,
                    validator: (value) =>
                        TValidator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Country')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.state.value,
                      items: controller.statesAndUTsList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateState,
                      decoration: const InputDecoration(labelText: 'State'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.district.value,
                      onChanged: controller.isDistrictDropdownEnabled.value
                          ? (newValue) {
                              controller.updateDistrict(newValue);
                            }
                          : null,
                      items: controller.districtsList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                enabled:
                                    controller.isDistrictDropdownEnabled.value,
                                child: Text(status),
                              ))
                          .toList(),
                      decoration: const InputDecoration(labelText: 'District'),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    controller: controller.city,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-z A-Z á-ú Á-Ú]')),
                    ],
                    validator: (value) =>
                        TValidator.validateEmptyText('City', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'City')),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-z A-Z á-ú Á-Ú 0-9 |/ |@ |, -]')),
                    ],
                    controller: controller.address,
                    validator: (value) =>
                        TValidator.validateEmptyText('Address', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Address')),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextFormField(
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: "*#####",
                        filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[1-9]')},
                      )
                    ],
                    controller: controller.pinCode,
                    validator: (value) =>
                        TValidator.validateEmptyText('PinCode', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'PinCode')),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewLocationDetailsToUserCollection();
                      Get.to(() => const TProfileScreen());
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
