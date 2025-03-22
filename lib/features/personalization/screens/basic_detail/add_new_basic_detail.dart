import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:poruththam_app/features/authentication/controllers/login/login_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/basic_detail_controller.dart';
import '../physical_detail/add_new_physical_details.dart';

class AddNewBasicDetailScreen extends StatelessWidget {
  const AddNewBasicDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BasicDetailController());
    final loginController = Get.put(LoginController());

    return Scaffold(
      appBar:
          const TAppBar(showBackArrow: true, title: Text('Add Basic Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.basicDetailsFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text('Name: ${controller.name.value}')),
                // Obx(
                //   () => TextFormField(
                //       readOnly: true,
                //       // inputFormatters: [
                //       //   FilteringTextInputFormatter.allow(
                //       //       RegExp('[a-z A-Z á-ú Á-Ú]')),
                //       // ],
                //       controller: controller.name.value,
                //       //initialValue: controller.fieldValue.value,
                //       validator: (value) =>
                //           TValidator.validateEmptyText('Name', value),
                //       decoration: const InputDecoration(
                //           hintText: 'Enter Name',
                //           prefixIcon: Icon(
                //             Iconsax.user,
                //           ),
                //           labelText: 'Name')),
                // ),
                // TextFormField(
                //     inputFormatters: [
                //       FilteringTextInputFormatter.allow(
                //           RegExp('[a-z A-Z á-ú Á-Ú]')),
                //     ],
                //     controller: controller.name.value,
                //     validator: (value) =>
                //         TValidator.validateEmptyText('Name', value),
                //     decoration: const InputDecoration(
                //         hintText: 'Enter Name',
                //         prefixIcon: Icon(
                //           Iconsax.user,
                //         ),
                //         labelText: 'Name')),
                const SizedBox(height: TSizes.spaceBtwItems),
                Column(
                  children: [
                    const Center(child: Text('Select Gender')),

                    /// Radio Button For Select Gender
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Radio Button for Male
                        Obx(() => Expanded(
                              child: RadioListTile(
                                title: const Text('Male'),
                                value: controller.genderList[0],
                                groupValue: controller.gender.value,
                                onChanged: (val) {
                                  controller.updateSelectedGender(val!);
                                },
                              ),
                            )),
                        // Radio Button for Female
                        Obx(() => Expanded(
                              child: RadioListTile(
                                title: const Text('Female'),
                                value: controller.genderList[1],
                                groupValue: controller.gender.value,
                                onChanged: (val) {
                                  controller.updateSelectedGender(val!);
                                },
                              ),
                            )),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// Drop Down Text Input Field For Date Of Birth
                Obx(
                  () => TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: "##-##-####")
                      ],
                      controller: TextEditingController(
                          text: controller.birthDate.value),
                      validator: (value) => TValidator.validateDate(value),
                      decoration: InputDecoration(
                          hintText: 'Click on Icon',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => controller.selectDate(context),
                          ),
                          labelText: 'Birth Date')),
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// Drop Down Text Input Field For Mother Tongue
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.motherTongue.value,
                      items: controller.languageList
                          .map((language) => DropdownMenuItem(
                                value: language,
                                child: Text(language),
                              ))
                          .toList(),
                      onChanged: controller.updateLanguage,
                      decoration:
                          const InputDecoration(labelText: 'Mother Tongue'),
                    );
                  },
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// Drop Down Text Input Field For Marital Status
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.maritalStatus.value,
                      items: controller.maritalStatusList
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: controller.updateMaritalStatus,
                      decoration:
                          const InputDecoration(labelText: 'Marital Status'),
                    );
                  },
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// Drop Down Text Input Field For Profile Creater
                Obx(
                  () {
                    return DropdownButtonFormField<String>(
                      value: controller.profileCreater.value,
                      items: controller.profilerList
                          .map((profile) => DropdownMenuItem(
                                value: profile,
                                child: Text(profile),
                              ))
                          .toList(),
                      onChanged: controller.updateProfiler,
                      decoration:
                          const InputDecoration(labelText: 'Profile Create By'),
                    );
                  },
                ),

                const SizedBox(height: TSizes.spaceBtwSections),

                /// Elevated Button For Submit Details
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addNewBasicDetailsToUserCollection();
                      Get.to(() => const AddNewPhysicalDetailScreen());
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
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.put(loginController.signOut()),
                      child: const Text('STATUS')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
