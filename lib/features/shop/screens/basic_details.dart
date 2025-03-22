// //import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// // import 'package:marriage/common/widgets/appbar/appbar.dart';
// // import 'package:marriage/features/personalization/controllers/basic_detail_controller.dart';
// // import 'package:marriage/test_file/test_radio_button.dart';
// // import 'package:marriage/utils/constants/colors.dart';
// //import '../poruththam/../common/enum.dart';
// import '../../../common/enum.dart';
// //import '../../../common/widgets/dropdown_form_field.dart';
// import '../../../common/widgets/dropdown_form_field.dart';
// import '../../../common/widgets/radio_button.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/constants/text_strings.dart';
// import '../../../utils/validators/validation.dart';
// import '../../personalization/controllers/basic_detail_controller.dart';
// //import '../../../features/personalization/controllers/basic_detail_controller.dart';
//
// //enum MartialStatusEnum { unmarried, married, diverse, widower }
//
// class TBasicDetails extends StatelessWidget {
//   TBasicDetails({super.key});
//
//   //CricketEnum? _cricketEnum;
//   //final SingleValueDropDownController _cnt = SingleValueDropDownController();
//   //final TextEditingController _cnt = TextEditingController();
//
//   final relationList = [
//     'Father',
//     'Mother',
//     'Brother',
//     'Sister',
//     'Relative',
//     'Friend'
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(BasicDetailController());
//
//     return Form(
//       key: controller.basicDetailsFormKey,
//       child: SafeArea(
//           child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(title: const Text('Basic Details'), centerTitle: true),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               /// Name
//               Container(
//                 color: Colors.purple.shade50,
//                 height: 50,
//                 width: double.infinity,
//                 child: TextFormField(
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z]+|\s")),
//                   ],
//                   keyboardType: TextInputType.name,
//                   validator: (value) =>
//                       TValidator.validateEmptyText('Name', value),
//                   controller: controller.name.value,
//                   expands: false,
//                   decoration: const InputDecoration(
//                       labelText: TTexts.name, prefixIcon: Icon(Iconsax.user)),
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               /// Gender
//               Row(
//                 children: [
//                   Obx(
//                     () => TRadioButton(
//                       title: GenderEnum.male.name.toUpperCase(),
//                       value: GenderEnum.male.name,
//                       groupValue: controller.selectedGender.value,
//                       onChanged: (value) {
//                         controller.selectedGenderValue(value);
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: TSizes.spaceBtwItems),
//                   Obx(
//                     () => TRadioButton(
//                       title: GenderEnum.female.name.toUpperCase(),
//                       value: GenderEnum.female.name,
//                       //title: 'Female',
//                       //value: 'female',
//                       groupValue: controller.selectedGender.value,
//                       onChanged: (value) {
//                         controller.selectedGenderValue(value);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               // Obx(
//               //   () => Text(controller.selectedGender.value,
//               //       style: const TextStyle(fontSize: 20)),
//               // ),
//               // const SizedBox(height: TSizes.spaceBtwItems),
//
//               /// Date Of Birth
//               Container(
//                 color: Colors.purple.shade50,
//                 height: 50,
//                 width: double.infinity,
//                 child: Obx(
//                   () => TextFormField(
//                     validator: (value) =>
//                         TValidator.validateEmptyText('Birth Date', value),
//                     controller: controller.dob.value,
//                     readOnly: true,
//                     decoration: const InputDecoration(
//                         labelText: 'Birth Date',
//                         hintText: "Enter Your Birth Date"),
//                     onTap: () => controller.onTapFunction(context: context),
//                     onChanged: (e) {
//                       controller.selectedBirthDate(e);
//                       print('birth is ${e}');
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               Obx(() => Text(
//                   'Gender Is ${controller.selectedGender.value},D.OB Is ${controller.dob.value.text}')),
//
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               /// Profile Creater Relationship
//               Container(
//                 color: Colors.purple.shade50,
//                 height: 50,
//                 width: double.infinity,
//                 child: TDropdownFormField(
//                     dropdown: controller.relationList,
//                     selectedVal: controller.relation,
//                     fieldName: 'Profile Created By'),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems),
//               Container(
//                 color: Colors.purple.shade50,
//                 height: 50,
//                 width: double.infinity,
//                 child: DropDownTextField(
//                     textFieldDecoration: const InputDecoration(
//                         icon: Icon(
//                       Icons.contacts,
//                       color: Colors.black54,
//                     )),
//                     controller: controller.selectedRelation.value,
//                     clearOption: true,
//                     enableSearch: false,
//                     clearIconProperty: IconProperty(color: Colors.green),
//                     searchTextStyle: const TextStyle(color: Colors.red),
//                     searchDecoration: const InputDecoration(
//                         hintText: "Search", icon: Icon(Icons.search)),
//                     validator: (value) => TValidator.validateEmptyText(
//                         'Select The Relation', value),
//                     dropDownList: relationList.map((e) {
//                       return DropDownValueModel(value: e, name: e.toString());
//                     }).toList(),
//                     onChanged: (value) {
//                       controller.selectedRelationValue(value);
//                       // print(
//                       //     'Selected Relation Is ${controller.selectedRelation.value.dropDownValue!.value}');
//                     }),
//               ),
//
//               const SizedBox(height: TSizes.spaceBtwItems),
//
//               /// Martial Status
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Obx(
//                         () => TRadioButton(
//                           //title: 'Un Married',
//                           title: MartialStatusEnum.unMarried.name.toUpperCase(),
//                           value: MartialStatusEnum.unMarried.name,
//                           groupValue: controller.selectedMartialStatus.value,
//                           onChanged: (value) {
//                             controller.selectedMartialStatusValue(value);
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: TSizes.spaceBtwItems),
//                       Obx(
//                         () => TRadioButton(
//                           //title: 'Married',
//                           title: MartialStatusEnum.married.name.toUpperCase(),
//                           value: MartialStatusEnum.married.name,
//                           groupValue: controller.selectedMartialStatus.value,
//                           onChanged: (value) {
//                             controller.selectedMartialStatusValue(value);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//                   Row(
//                     children: [
//                       Obx(
//                         () => TRadioButton(
//                           title: 'WIDOW(ER)',
//                           //title: MartialStatusEnum.widower.name.toUpperCase(),
//                           value: MartialStatusEnum.widower.name,
//                           groupValue: controller.selectedMartialStatus.value,
//                           onChanged: (value) {
//                             controller.selectedMartialStatusValue(value);
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: TSizes.spaceBtwItems),
//                       Obx(
//                         () => TRadioButton(
//                           title: MartialStatusEnum.divorce.name.toUpperCase(),
//                           value: MartialStatusEnum.divorce.name,
//                           groupValue: controller.selectedMartialStatus.value,
//                           onChanged: (value) {
//                             controller.selectedMartialStatusValue(value);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: TSizes.spaceBtwItems),
//                   // Obx(
//                   //   () => Text(
//                   //       controller.selectedMartialStatus.value.toUpperCase(),
//                   //       style: const TextStyle(fontSize: 20)),
//                   // ),
//                 ],
//               ),
//
//               const SizedBox(height: TSizes.spaceBtwSections),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => controller.submit(),
//                   child: const Text(TTexts.submitDetails),
//                 ),
//               ),
//               // Obx(
//               //   () => Text(
//               //     controller.textVal.value,
//               //     //controller.age.toString(),
//               //     //controller.gender.value,
//               //     //maleEndDate,
//               //     //controller.selectedVal.value.toUpperCase(),
//               //     style: const TextStyle(fontSize: 30),
//               //   ),
//               // ),
//               // const SizedBox(height: TSizes.spaceBtwItems),
//               // Obx(
//               //   () => Text(
//               //     controller.age.value.toString(),
//               //     //maleEndDate,
//               //     // controller.selectedVal.value.toUpperCase(),
//               //     style: const TextStyle(fontSize: 30),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
