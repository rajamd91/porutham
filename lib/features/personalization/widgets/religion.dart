import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/models/religious_model.dart';

import '../../../utils/constants/sizes.dart';
import '../models/locationDetailModel.dart';

class Religion extends StatelessWidget {
  const Religion({
    super.key,
    required this.religiousData,
  });

  final ReligiousDetailModel religiousData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Religious Details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Religion: ${religiousData.religion}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Madhab: ${religiousData.madhab}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Division : ${religiousData.division}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Jamath : ${religiousData.jamath}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Follows  : ${religiousData.follows}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Religious Value  : ${religiousData.religiousValues}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Doc Id  : ${religiousData.docId}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
