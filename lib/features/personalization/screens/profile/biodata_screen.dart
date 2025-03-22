import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/controllers/family_detail_controller.dart';
import 'package:poruththam_app/features/personalization/controllers/physical_status_controller.dart';
import 'package:poruththam_app/features/personalization/controllers/profession_controller.dart';
import 'package:poruththam_app/features/personalization/controllers/religious_controller.dart';
import 'package:poruththam_app/features/personalization/controllers/user_controller.dart';
import 'package:poruththam_app/features/personalization/models/family_details_model.dart';
import 'package:poruththam_app/features/personalization/models/locationDetailModel.dart';
import 'package:poruththam_app/features/personalization/models/physical_detail_model.dart';
import 'package:poruththam_app/features/personalization/models/religious_model.dart';
import 'package:poruththam_app/features/personalization/widgets/basic_detail_widget.dart';
import 'package:poruththam_app/features/personalization/widgets/family_detail_widget.dart';
import 'package:poruththam_app/features/personalization/widgets/physical_detail_widget.dart';
import 'package:poruththam_app/features/personalization/widgets/religion.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/basic_detail_controller.dart';
import '../../controllers/location_detail_controller.dart';
import '../../models/basic_detail_model.dart';
import '../../models/profession_model.dart';
import '../../widgets/location.dart';
import '../../widgets/profession.dart';

class BioDataScreen extends StatelessWidget {
  const BioDataScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final professionController = Get.put(ProfessionController());
    final locationController = Get.put(LocationController());
    final religiousController = Get.put(ReligiousController());
    final basicDetailController = Get.put(BasicDetailController());
    final physicalDetailController = Get.put(PhysicalDetailController());
    final familyDetailController = Get.put(FamilyController());
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(children: [
                Obx(() {
                  final networkImage = controller.user.value.profilePicture;
                  final image =
                      networkImage.isNotEmpty ? networkImage : TImages.user;
                  return controller.imageUploading.value
                      ? const TShimmerEffect(
                          width: 80,
                          height: 80,
                          radius: 80,
                        )
                      : TCircularImage(
                          image: image,
                          width: 80,
                          height: 80,
                          isNetworkImage: networkImage.isNotEmpty,
                        );
                }),
                TextButton(
                    onPressed: () => controller.uploadUserProfilePicture(),
                    child: const Text('Change Profile Picture')),
              ]),
            ),

            /// Basic Details
            FutureBuilder(
              future: basicDetailController.getBasicDetailData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    BasicDetailModel basicDetailData =
                        snapshot.data as BasicDetailModel;

                    return BasicDetailsWidget(basicDetailData: basicDetailData);
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
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Profession Details
            FutureBuilder(
              future: professionController.getProfessionData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    ProfessionDetailModel professionData =
                        snapshot.data as ProfessionDetailModel;

                    return Profession(professionData: professionData);
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
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Location Details
            FutureBuilder(
              future: locationController.getLocationData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    LocationDetailModel locationData =
                        snapshot.data as LocationDetailModel;
                    print(locationController.getLocationData());

                    return Location(locationData: locationData);
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
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Physical Details
            FutureBuilder(
              future: physicalDetailController.getPhysicalData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    PhysicalDetailModel physicalData =
                        snapshot.data as PhysicalDetailModel;
                    print(physicalDetailController.getPhysicalData());

                    return PhysicalDetailWidget(
                      physicalData: physicalData,
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
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Religious Details
            FutureBuilder(
              future: religiousController.getReligiousData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    ReligiousDetailModel religiousData =
                        snapshot.data as ReligiousDetailModel;
                    print(religiousController.getReligiousData());

                    return Religion(religiousData: religiousData);
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

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Family Details
            FutureBuilder(
              future: familyDetailController.getFamilyData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    FamilyDetailModel familyData =
                        snapshot.data as FamilyDetailModel;
                    print(familyDetailController.getFamilyData());

                    return FamilyDetailWidget(
                      familyData: familyData,
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
          ],
        ),
      ),
    );
  }
}
