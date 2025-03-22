import 'package:flutter/material.dart';
import 'package:poruththam_app/features/personalization/models/family_details_model.dart';
import '../../../utils/constants/sizes.dart';

class FamilyDetailWidget extends StatelessWidget {
  const FamilyDetailWidget({
    super.key,
    required this.familyData,
  });

  final FamilyDetailModel familyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Family Details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Family Type: ${familyData.familyType}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Family Status: ${familyData.familyStatus}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Father Occupation : ${familyData.fatherOccupation}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Mother Occupation : ${familyData.motherOccupation}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Family Origin  : ${familyData.familyOrigin}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('No Of Brothers  : ${familyData.noOfBrothers}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Brothers married  : ${familyData.brothersMarried}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('No Of Sisters  : ${familyData.noOfSisters}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Sisters married  : ${familyData.sistersMarried}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Doc Id  : ${familyData.docId}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
