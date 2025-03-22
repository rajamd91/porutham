import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';
import '../models/basic_detail_model.dart';
import '../models/locationDetailModel.dart';

class BasicDetailsWidget extends StatelessWidget {
  const BasicDetailsWidget({
    super.key,
    required this.basicDetailData,
  });

  final BasicDetailModel basicDetailData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Name: ${basicDetailData.name}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Gender: ${basicDetailData.gender}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('D.O.B : ${basicDetailData.birthDate}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Marital Status : ${basicDetailData.maritalStatus}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Profile Create By  : ${basicDetailData.profileCreater}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Doc Id  : ${basicDetailData.docId}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
