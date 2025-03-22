import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:poruththam_app/features/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  TTexts.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                const TSignupForm(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                /// Divider
                TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Social Buttons
                const TSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
