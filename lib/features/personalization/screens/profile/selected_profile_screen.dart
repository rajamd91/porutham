import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';
import 'package:poruththam_app/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:poruththam_app/features/personalization/screens/profile/widgets/profile_menu.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../authentication/controllers/login/login_controller.dart';
import '../../../personalization/controllers/user_controller.dart';

class SelectedProfileScreen extends StatelessWidget {
  const SelectedProfileScreen({super.key, required this.bioData});

  //final String profileId;
  final BioDataModel bioData;

  // Future<void> getData() async {
  //   // final bioDataController = Get.put(UserController());
  //   // var bioData = await bioDataController.fetchProfileRecord(profileId);
  //
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .where('ProfileId', isEqualTo: profileId)
  //       .get();
  //   userData = snapshot.docs.map((e) => BioDataModel.fromSnapshot(e)).single;
  // }

  @override
  Widget build(BuildContext context) {
    final userRepo = Get.put(UserRepository());
    final controller = UserController.instance;
    final loginController = Get.put(LoginController());

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
                      final networkImage = bioData.profilePicture;
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
                    Text(
                      'Profile ID:${bioData.profileId}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      bioData.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // TextButton(
                    //     onPressed: () => controller.uploadUserProfilePicture(),
                    //     child: const Text('Change Profile Picture'))
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Details
              SizedBox(
                height: TSizes.spaceBtwSections,
                width: double.infinity,
                child: Container(
                  color: Colors.pink,
                  child: Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            final user = controller.user.value;
                            final email = bioData.email;
                            final subject =
                                'You Are Shortlisted :: ${DateTime.now()}';
                            final message =
                                'Hi ${bioData.name}, You Are Shortlisted By ${user.fullName} (Profile Id:${user.profileId})';
                            userRepo.sendGmail(email, subject, message);
                          },
                          icon: const Icon(Iconsax.star1, size: 20),
                          label: const Text('Shortlist',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(width: TSizes.sm),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Iconsax.call_add5,
                              size: 20, color: Colors.yellow),
                          label: const Text('Connect',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(width: TSizes.sm),
                      TextButton.icon(
                          onPressed: () {
                            final user = controller.user.value;
                            final email = bioData.email;
                            final subject =
                                '${user.fullName} is Interested in you';
                            final message =
                                "Dear ${bioData.name}, ${user.fullName} (Profile Id:${user.profileId}) has expressed interest in your profile.";
                            userRepo.sendGmail(email, subject, message);
                          },
                          icon: const Icon(
                            Iconsax.heart5,
                            size: 20,
                            color: Colors.green,
                          ),
                          label: const Text('Interest',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      //const SizedBox(width: TSizes.sm),
                    ],
                  ),
                ),
              ),
              //const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading profile info
              // const TSectionHeading(
              //     title: 'Profile Information', showActionButton: false),
              // const SizedBox(height: TSizes.spaceBtwItems),
              //
              // TProfileMenu(
              //     title: 'name',
              //     value: bioData.name,
              //     onPressed: () => Get.to(() => const ChangeName())),
              // TProfileMenu(
              //     title: 'Username', value: bioData.userName, onPressed: () {}),
              // const SizedBox(height: TSizes.spaceBtwItems),
              // const Divider(),
              // const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const TSectionHeading(
                  title: 'Contact Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // TProfileMenu(
              //     title: 'User ID', value: bioData.id, onPressed: () {}),
              TProfileMenu(
                  title: 'E-mail', value: bioData.email, onPressed: () {}),
              TProfileMenu(
                  title: 'Phone Number',
                  value: bioData.phoneNumber,
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
              TProfileMenu(
                title: 'Name',
                value: bioData.name,
                onPressed: () {},
              ),

              TProfileMenu(
                  onPressed: () {}, title: 'Gender', value: bioData.gender),
              TProfileMenu(
                  onPressed: () {}, title: 'D.O.B', value: bioData.birthDate),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Marital Status',
                  value: bioData.maritalStatus),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Profile Created By',
                  value: bioData.profileCreater),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Physical Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  title: 'Physical Status',
                  value: bioData.physicalStatus,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Body Type',
                  value: bioData.bodyType,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Color', value: bioData.color, onPressed: () {}),
              TProfileMenu(
                  title: 'Height', value: bioData.height, onPressed: () {}),
              TProfileMenu(
                  title: 'Weight', value: bioData.weight, onPressed: () {}),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Profession Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  title: 'Education',
                  value: bioData.education,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Education Detail',
                  value: bioData.educationDetail,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Occupation',
                  value: bioData.occupation,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Occupation Detail',
                  value: bioData.occupationDetail,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Employed In',
                  value: bioData.employedIn,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Annual Income',
                  value: bioData.income,
                  onPressed: () {}),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Family Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  title: 'Family Type',
                  value: bioData.familyType,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Family Status',
                  value: bioData.familyStatus,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Family origin',
                  value: bioData.familyOrigin,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Father Occupation',
                  value: bioData.fatherOccupation,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Mother Occupation',
                  value: bioData.motherOccupation,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'No Of Brothers',
                  value: bioData.noOfBrothers,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Brothers married',
                  value: bioData.brothersMarried,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'No Of Sisters',
                  value: bioData.noOfSisters,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Sisters married',
                  value: bioData.sistersMarried,
                  onPressed: () {}),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Religious Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  title: 'Religion', value: bioData.religion, onPressed: () {}),
              TProfileMenu(
                  title: 'Division', value: bioData.division, onPressed: () {}),
              TProfileMenu(
                  title: 'Madhab', value: bioData.madhab, onPressed: () {}),
              TProfileMenu(
                  title: 'Follows', value: bioData.follows, onPressed: () {}),
              TProfileMenu(
                  title: 'religious Values',
                  value: bioData.religiousValues,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Jamath', value: bioData.jamath, onPressed: () {}),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Location Details', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  title: 'Address', value: bioData.address, onPressed: () {}),
              TProfileMenu(
                  title: 'City', value: bioData.city, onPressed: () {}),
              TProfileMenu(
                  title: 'District', value: bioData.district, onPressed: () {}),
              TProfileMenu(
                  title: 'State', value: bioData.state, onPressed: () {}),
              TProfileMenu(
                  title: 'Country', value: bioData.country, onPressed: () {}),
              TProfileMenu(
                  title: 'Pin code', value: bioData.pincode, onPressed: () {}),

              //const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                height: TSizes.spaceBtwSections,
                width: double.infinity,
                child: Container(
                  color: Colors.pink,
                  child: Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            final user = controller.user.value;
                            final email = bioData.email;
                            final subject =
                                'You Are Shortlisted :: ${DateTime.now()}';
                            final message =
                                'Hi ${bioData.name}, You Are Shortlisted By ${user.fullName} (Profile Id:${user.profileId})';
                            userRepo.sendGmail(email, subject, message);
                          },
                          icon: const Icon(Iconsax.star1, size: 20),
                          label: const Text('Shortlist',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(width: TSizes.sm),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Iconsax.call_add5,
                              size: 20, color: Colors.yellow),
                          label: const Text('Connect',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(width: TSizes.sm),
                      TextButton.icon(
                          onPressed: () {
                            final user = controller.user.value;
                            final email = bioData.email;
                            final subject =
                                '${user.fullName} is Interested in you';
                            final message =
                                "Dear ${bioData.name}, ${user.fullName} (Profile Id:${user.profileId}) has expressed interest in your profile.";
                            userRepo.sendGmail(email, subject, message);
                          },
                          icon: const Icon(
                            Iconsax.heart5,
                            size: 20,
                            color: Colors.green,
                          ),
                          label: const Text('Interest',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      //const SizedBox(width: TSizes.sm),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // SizedBox(
              //   width: double.infinity,
              //   child: OutlinedButton(
              //       onPressed: () => Get.put(loginController.signOut()),
              //       child: const Text(
              //         'Logout',
              //         style: TextStyle(
              //             color: Colors.green,
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold),
              //       )),
              // ),
              // const SizedBox(height: TSizes.spaceBtwItems),
              // SizedBox(
              //   width: double.infinity,
              //   child: TextButton(
              //       onPressed: () => controller.deleteAccountWarningPopup(),
              //       child: const Text(
              //         'Close Account',
              //         style: TextStyle(
              //             color: Colors.red,
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold),
              //       )),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
