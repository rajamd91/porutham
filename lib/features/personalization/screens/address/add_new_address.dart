import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar:
          const TAppBar(showBackArrow: true, title: Text('Add New Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                    controller: controller.name,
                    validator: (value) =>
                        TValidator.validateEmptyText('Name', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.user,
                        ),
                        labelText: 'Name')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.phoneNumber,
                    validator: TValidator.validatePhoneNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.mobile,
                        ),
                        labelText: 'Phone Number')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.street,
                            validator: (value) =>
                                TValidator.validateEmptyText('Street', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Iconsax.building_31,
                                ),
                                labelText: 'Street'))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            controller: controller.postalCode,
                            validator: (value) => TValidator.validateEmptyText(
                                'PostalCode', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Iconsax.code,
                                ),
                                labelText: 'Postal Code'))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.city,
                            validator: (value) =>
                                TValidator.validateEmptyText('City', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Iconsax.building,
                                ),
                                labelText: 'City'))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            controller: controller.state,
                            validator: (value) =>
                                TValidator.validateEmptyText('State', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Iconsax.activity,
                                ),
                                labelText: 'State'))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.country,
                    validator: (value) =>
                        TValidator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.global,
                        ),
                        labelText: 'Country')),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.addNewAddresses(),
                      child: const Text('SAVE')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
