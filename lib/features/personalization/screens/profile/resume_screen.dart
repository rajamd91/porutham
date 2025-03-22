import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/features/personalization/controllers/basic_detail_controller.dart';
import 'package:poruththam_app/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:poruththam_app/features/personalization/screens/profile/widgets/profile_menu.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../authentication/controllers/login/login_controller.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../controllers/family_detail_controller.dart';
import '../../controllers/location_detail_controller.dart';
import '../../controllers/physical_status_controller.dart';
import '../../controllers/profession_controller.dart';
import '../../controllers/religious_controller.dart';

class TProfileScreen extends StatelessWidget {
  const TProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final basicDetailController = Get.put(BasicDetailController());
    //final basicDetailController = BasicDetailController.instance;
    final physicalDetailController = Get.put(PhysicalDetailController());
    //final physicalDetailController = PhysicalDetailController.instance;
    final professionDetailController = Get.put(ProfessionController());
    final familyDetailController = Get.put(FamilyController());
    final religiousDetailController = Get.put(ReligiousController());
    final locationDetailController = Get.put(LocationController());
    final loginController = Get.put(LoginController());

    //final professionDetailController = ProfessionController.instance;
    // final professionController = ProfessionController.instance;
    // final locationController = LocationController.instance;
    // final religiousController = ReligiousController.instance;
    // final physicalDetailController = PhysicalDetailController.instance;
    // final familyDetailController = FamilyController.instance;

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile')),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
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
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading profile info
              const TSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'name',
                  value: controller.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName())),
              TProfileMenu(
                  title: 'Username',
                  value: controller.user.value.userName,
                  onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const TSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'E-mail',
                  value: controller.user.value.email,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Phone Number',
                  value: controller.user.value.phoneNumber,
                  onPressed: () {}),
              // TProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              // TProfileMenu(
              //     title: 'Date of Birth',
              //     value: '10 Oct, 1994',
              //     onPressed: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Basic Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                    title: 'Name',
                    value: basicDetailController.basic.value.name,
                    onPressed: () {},
                  )),

              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'Gender',
                  value: basicDetailController.basic.value.gender)),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'D.O.B',
                  value: basicDetailController.basic.value.birthDate)),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'Marital Status',
                  value: basicDetailController.basic.value.maritalStatus)),
              Obx(() => TProfileMenu(
                  onPressed: () {},
                  title: 'Profile Created By',
                  value: basicDetailController.basic.value.profileCreater)),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Physical Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                  title: 'Physical Status',
                  value: physicalDetailController.physical.value.physicalStatus,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Body Type',
                  value: physicalDetailController.physical.value.bodyType,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Color',
                  value: physicalDetailController.physical.value.color,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Height',
                  value: physicalDetailController.physical.value.height,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Weight',
                  value: physicalDetailController.physical.value.weight,
                  onPressed: () {})),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Profession Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                  title: 'Education',
                  value: professionDetailController.profession.value.education,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Education Detail',
                  value: professionDetailController
                      .profession.value.educationDetail,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Occupation',
                  value: professionDetailController.profession.value.occupation,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Occupation Detail',
                  value: professionDetailController
                      .profession.value.occupationDetail,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Employed In',
                  value: professionDetailController.profession.value.employedIn,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Annual Income',
                  value: professionDetailController.profession.value.income,
                  onPressed: () {})),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Family Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                  title: 'Family Type',
                  value: familyDetailController.family.value.familyType,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Family Status',
                  value: familyDetailController.family.value.familyStatus,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Family origin',
                  value: familyDetailController.family.value.familyOrigin,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Father Occupation',
                  value: familyDetailController.family.value.fatherOccupation,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Mother Occupation',
                  value: familyDetailController.family.value.motherOccupation,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'No Of Brothers',
                  value: familyDetailController.family.value.noOfBrothers,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Brothers married',
                  value: familyDetailController.family.value.brothersMarried,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'No Of Sisters',
                  value: familyDetailController.family.value.noOfSisters,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Sisters married',
                  value: familyDetailController.family.value.sistersMarried,
                  onPressed: () {})),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Religious Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                  title: 'Religion',
                  value: religiousDetailController.religious.value.religion,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Division',
                  value: religiousDetailController.religious.value.division,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Madhab',
                  value: religiousDetailController.religious.value.madhab,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Follows',
                  value: religiousDetailController.religious.value.follows,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'religious Values',
                  value:
                      religiousDetailController.religious.value.religiousValues,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Jamath',
                  value: religiousDetailController.religious.value.jamath,
                  onPressed: () {})),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Location Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => TProfileMenu(
                  title: 'Address',
                  value: locationDetailController.location.value.address,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'City',
                  value: locationDetailController.location.value.city,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'District',
                  value: locationDetailController.location.value.district,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'State',
                  value: locationDetailController.location.value.state,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Country',
                  value: locationDetailController.location.value.country,
                  onPressed: () {})),
              Obx(() => TProfileMenu(
                  title: 'Pin code',
                  value: locationDetailController.location.value.pincode,
                  onPressed: () {})),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.put(loginController.signOut()),
                    child: const Text('Logout')),
              ),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text(
                      'Close Account',
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
