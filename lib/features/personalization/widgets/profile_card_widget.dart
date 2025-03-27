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
    this.onMorePressed,
    this.onShortlistPressed,
    this.onInterestPressed,
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
  final VoidCallback? onMorePressed;
  final VoidCallback? onShortlistPressed;
  final VoidCallback? onInterestPressed;

  @override
  Widget build(BuildContext context) {
    final userRepo = Get.put(UserRepository());
    final controller = Get.put(UserController());
    final textTheme = Theme.of(context).textTheme;
    final blackTextStyle = textTheme.bodyMedium?.apply(color: TColors.black);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Column(
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
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      //size: 5,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Wrap(
                //spacing: TSizes.spaceBtwItems / 2,
                children: [
                  _buildInfoChip(age),
                  _buildInfoChip(height),
                  _buildInfoChip(religion),
                  // Text(age,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .apply(color: TColors.black)),
                  // Text(height,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .apply(color: TColors.black)),
                  // Text(religion,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .apply(color: TColors.black)),
                ],
              ),
              Wrap(
                //spacing: TSizes.spaceBtwItems / 4,
                children: [
                  _buildInfoChip(division),
                  _buildInfoChip(city),
                  _buildInfoChip(motherTongue),
                  // Text(division,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .apply(color: TColors.black)),
                  // Text(city,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .apply(color: TColors.black)),
                  // Text(motherTongue,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyMedium!
                  //         .apply(color: TColors.black)),
                ],
              ),

              Wrap(
                alignment: WrapAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Shortlist Button
                  TextButton.icon(
                    onPressed: onShortlistPressed ??
                        () {
                          final user = controller.user.value;
                          final subject =
                              'You Are Shortlisted :: ${DateTime.now()}';
                          final message =
                              'Hi $name, You Are Shortlisted By ${user.fullName} (Profile Id:${user.profileId})';
                          userRepo.sendGmail(email, subject, message);
                        },
                    icon: const Icon(Iconsax.star1, size: TSizes.iconXs),
                    label: Text('Shortlist', style: blackTextStyle),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     final firstName = controller.user.value.fullName;
                  //     final profileId = controller.user.value.profileId;
                  //
                  //     final String subject =
                  //         'You Are Shortlisted :: 😀 :: ${DateTime.now()}';
                  //     final String messageText =
                  //         'Hi $name,You Are Shortlisted By $firstName (Profile Id:$profileId)';
                  //     userRepo.sendGmail(email, subject, messageText);
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       const Icon(Iconsax.star1),
                  //       Text('Shortlist',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodySmall!
                  //               .apply(color: TColors.black)),
                  //     ],
                  //   ),
                  // ),
                  //const SizedBox(width: TSizes.spaceBtwInputFields),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.chart),
                    label: Text('54 mins ago', style: blackTextStyle),
                  ),

                  TextButton.icon(
                    onPressed: onInterestPressed ??
                        () {
                          final user = controller.user.value;
                          final subject =
                              '${user.fullName} is Interested in you';
                          final message =
                              "Dear $name, ${user.fullName} (Profile Id:${user.profileId}) has expressed interest in your profile.";
                          userRepo.sendGmail(email, subject, message);
                        },
                    icon: const Icon(Iconsax.tick_circle, size: TSizes.iconXs),
                    label: Text('Interest', style: blackTextStyle),
                  ),

                  // TextButton(
                  //   onPressed: () {
                  //     final firstName = controller.user.value.fullName;
                  //     final profileId = controller.user.value.profileId;
                  //
                  //     final String subject =
                  //         '$firstName is Interested in you.Respond to her.';
                  //     final String messageText =
                  //         "Dear $name,$firstName (Profile Id:$profileId) has expressed an interest in your profile.Don't wait,connect now";
                  //     userRepo.sendGmail(email, subject, messageText);
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       const Icon(Iconsax.tick_circle),
                  //       Text('Interest',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodySmall!
                  //               .apply(color: TColors.black)),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              //const Divider(thickness: 1, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Chip(
      label: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
