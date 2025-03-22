import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/validators/validation.dart';

class TDropdownFormField extends StatelessWidget {
  const TDropdownFormField(
      {super.key,
      required this.dropdown,
      required this.selectedVal,
      required this.fieldName});

  /// Variables
  final List<String> dropdown;
  final RxString selectedVal;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(BasicDetailController());
    return DropdownButtonFormField(
      validator: (value) => TValidator.validateEmptyText(fieldName, value),
      //icon: const Icon(Iconsax.people),
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid))),
      value: selectedVal.value,
      items: dropdown.map((e) {
        //return DropDownValueModel(value: e, name: Text(e));
        return DropdownMenuItem(value: e, child: Text(e.toUpperCase()));
      }).toList(),
      onChanged: ((value) {
        selectedVal.value = value as String;
        print(Text('Profile Created By ${selectedVal.value}'));
        //controller.marriageAgeCal();
      }),
    );
  }
}
