import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:poruththam_app/features/personalization/screens/family_detail/add_new_family_details.dart';
import 'package:poruththam_app/features/personalization/screens/location/add_new_location_details.dart';
import 'package:poruththam_app/features/personalization/screens/profession_detail/add_new_profession_detail.dart';
import 'package:poruththam_app/features/personalization/screens/religion/add_new_religious_details.dart';
import 'package:poruththam_app/features/personalization/widgets/user_card_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../authentication/controllers/login/login_controller.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';
import '../basic_detail/add_new_basic_detail.dart';
import '../physical_detail/add_new_physical_details.dart';
import '../profile/profile.dart';
import '../profile/resume_screen.dart';
import '../profile/update_profile_screen.dart';
import '../test/form_progress_indicator/form_progress_indicator.dart';
import '../test/gmail_sent.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      "Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),

                  /// User Profile Card
                  TUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Settings
                  const TSectionHeading(
                      title: "Account Settings", showActionButton: false),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Test",
                      subTitle: "Profile Indicator",
                      onTap: () => Get.to(() => const IndicatorScreen())),

                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Test",
                      subTitle: "Send Gmail",
                      onTap: () => Get.to(() => const SendGmail())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Test",
                      subTitle: "Test1",
                      onTap: () => Get.to(() => const UserCard())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Test",
                      subTitle: "Test2",
                      onTap: () => Get.to(() => const UpdateProfileScreen())),

                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Bio Data",
                      subTitle: "Profile Of The User",
                      onTap: () => Get.to(() => const TProfileScreen())),

                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Basic Details",
                      subTitle: "Basic Details Of The User",
                      onTap: () =>
                          Get.to(() => const AddNewBasicDetailScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Physical Details",
                      subTitle: "Physical Details Of The User",
                      onTap: () =>
                          Get.to(() => const AddNewPhysicalDetailScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Profession Details",
                      subTitle: "Profession Details Of The User",
                      onTap: () =>
                          Get.to(() => const AddNewProfessionDetailScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Family Details",
                      subTitle: "Family Details Of The User",
                      onTap: () =>
                          Get.to(() => const AddNewFamilyDetailScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Religious Details",
                      subTitle: "Religious Details Of The User",
                      onTap: () =>
                          Get.to(() => const AddNewReligiousDetailScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.profile,
                      title: "Location Details",
                      subTitle: "Location Details Of The User",
                      onTap: () =>
                          Get.to(() => const AddNewLocationDetailScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: "My Addresses",
                      subTitle: "Set shopping delivery address",
                      onTap: () => Get.to(() => const UserAddressScreen())),
                  const TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: "My Cart",
                      subTitle: "Add remove products and save to checkout"),
                  TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subTitle: "In progress and completed Orders",
                      onTap: () => Get.to(() => const OrderScreen())),
                  const TSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: "Bank Account",
                      subTitle: "Withdraw balance to registered bank account"),
                  const TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: "My Coupons",
                      subTitle: "List of all the discounted coupons"),
                  const TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subTitle: "Set any kind of notification message"),
                  const TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: "Account Privacy",
                      subTitle: "Manage data usage and connected accounts"),

                  /// App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: "App Settings", showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subTitle: "Upload data to your Cloud Firebase"),
                  TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: "GeoLocation",
                      subTitle: 'Set recommendation based on location',
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      )),
                  TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: "Safe Mode",
                      subTitle: 'Search result is safe for all ages',
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      )),
                  TSettingsMenuTile(
                      icon: Iconsax.image,
                      title: "No Image Quality",
                      subTitle: 'Set image quality to be seen',
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      )),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => Get.put(controller.signOut()),
                        child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
