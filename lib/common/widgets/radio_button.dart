import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import '../../features/personalization/controllers/basic_detail_controller.dart';
//enum MartialStatusEnum { unmarried, married, diverse, widower }

class TRadioButton extends StatelessWidget {
  TRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  final String title;
  final String value;
  final String groupValue;
  Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    //Get.put(BasicDetailController());
    return Expanded(
      child: RadioListTile(
        title: Text(title),
        contentPadding: const EdgeInsets.all(0.0),
        tileColor: Colors.purple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        dense: true,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
