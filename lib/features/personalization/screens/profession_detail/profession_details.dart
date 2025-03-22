import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/controllers/profession_controller.dart';
import 'package:poruththam_app/features/personalization/models/profession_model.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
//import '../profile/biodata_screen.dart';

class ProfessionDetails extends StatelessWidget {
  const ProfessionDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfessionController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: FutureBuilder(
          future: controller.getProfessionData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                ProfessionDetailModel professionData =
                    snapshot.data as ProfessionDetailModel;
                print(controller.getProfessionData());

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profession Details',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
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
                    Text('Occupation Detail:${professionData.occupationDetail}',
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
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: Text('Something Went Wrong'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
