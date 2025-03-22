import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';

import '../../../common/widgets/images/t_circular_image.dart';
import '../../../common/widgets/shimmers/shimmer.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/user_controller.dart';

class TProfileCard extends StatelessWidget {
  const TProfileCard({
    super.key,
    //required this.image,
    required this.profileId,
    required this.name,
    required this.age,
    required this.height,
    required this.religion,
    required this.division,
    required this.city,
    required this.motherTongue,
    required this.image,
    required this.email,
  });

  final String image;
  final String profileId;
  final String name;
  final String age;
  final String height;
  final String religion;
  final String division;
  final String city;
  final String motherTongue;
  final String email;

  @override
  Widget build(BuildContext context) {
    final userRepo = Get.put(UserRepository());
    final controller = Get.put(UserController());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final networkImage = image;
                  final timage =
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
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileId,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: TColors.black)),
                    Text(name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.black)),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      children: [
                        Text(age,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text(height,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text(religion,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        Text(division,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text(city,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text(motherTongue,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      //size: 5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    final firstName = controller.user.value.fullName;
                    final profileId = controller.user.value.profileId;

                    final String subject =
                        'You Are Shortlisted :: 😀 :: ${DateTime.now()}';
                    final String messageText =
                        'Hi $name,You Are Shortlisted By $firstName (Profile Id:$profileId)';
                    userRepo.sendGmail(email, subject, messageText);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Iconsax.star1),
                      Text('Shortlist',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: TColors.black)),
                    ],
                  ),
                ),
                //const SizedBox(width: TSizes.spaceBtwInputFields),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.chart),
                ),
                Text('54 mins ago',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: TColors.black)),

                TextButton(
                  onPressed: () {
                    final firstName = controller.user.value.fullName;
                    final profileId = controller.user.value.profileId;

                    final String subject =
                        '$firstName is Interested in you.Respond to her.';
                    final String messageText =
                        "Dear $name,$firstName (Profile Id:$profileId) has expressed an interest in your profile.Don't wait,connect now";
                    userRepo.sendGmail(email, subject, messageText);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Iconsax.tick_circle),
                      Text('Interest',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: TColors.black)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
