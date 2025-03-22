import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';
import 'package:poruththam_app/utils/constants/sizes.dart';

import '../../../common/widgets/images/t_circular_image.dart';
import '../../../utils/constants/colors.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: TAppBar(title: Text('Profiles')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                const TCircularImage(
                  image: 'assets/images/profile/ishwarya.jpeg',
                  width: 120,
                  height: 120,
                  padding: 0,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TIM2025201',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: TColors.black)),
                    Text('Shilpa Shetty',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.black)),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      children: [
                        Text('20 Yrs,',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text('5ft 2in/157cm,',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text('Muslim-',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Rowther,',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text('Coimbatore,',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: TColors.black)),
                        Text('Tamil...',
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

              // subtitle: Text('rajamd50@gmail.com', //controller.user.value.email,
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyMedium!
              //         .apply(color: TColors.black)),
              // trailing: IconButton(
              //   onPressed: () {}, //onPressed,
              //   icon: const Icon(Iconsax.edit, color: TColors.white),
              // ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.star1),
                ),
                Text('Shortlist',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: TColors.black)),
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
                //const SizedBox(width: TSizes.spaceBtwInputFields),
                //const SizedBox(width: TSizes.spaceBtwInputFields),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.tick_circle),
                ),
                Text('Interest',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: TColors.black)),

                //const SizedBox(width: TSizes.spaceBtwInputFields),
              ],
            ),

            //const Divider(thickness: 1, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
