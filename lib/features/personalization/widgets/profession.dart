import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';
import '../models/profession_model.dart';

class Profession extends StatelessWidget {
  const Profession({
    super.key,
    required this.professionData,
  });

  final ProfessionDetailModel professionData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profession Details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Education: ${professionData.education}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Education Detail: ${professionData.educationDetail}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Employed In : ${professionData.employedIn}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Occupation : ${professionData.occupation}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Occupation Detail  : ${professionData.occupationDetail}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Annual Income  : ${professionData.income}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Doc Id  : ${professionData.docId}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
