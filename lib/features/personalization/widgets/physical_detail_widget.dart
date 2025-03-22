import 'package:flutter/material.dart';
import 'package:poruththam_app/features/personalization/models/physical_detail_model.dart';
import '../../../utils/constants/sizes.dart';

class PhysicalDetailWidget extends StatelessWidget {
  const PhysicalDetailWidget({
    super.key,
    required this.physicalData,
  });

  final PhysicalDetailModel physicalData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Physical Details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('PhysicalStatus: ${physicalData.physicalStatus}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Height: ${physicalData.height}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Weight : ${physicalData.weight}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Color : ${physicalData.color}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Body Type : ${physicalData.bodyType}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Doc Id  : ${physicalData.docId}',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
