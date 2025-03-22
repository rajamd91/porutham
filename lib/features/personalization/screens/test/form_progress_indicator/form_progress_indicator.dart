import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/bindings/general_bindings.dart';
import 'form_indicator.dart';
import 'form_progress_controller.dart';

class IndicatorScreen extends StatelessWidget {
  const IndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialApp(
        home: const IndicatorScreenWidget(),
        //initialBinding: GeneralBindings(),
      ),
      //body: IndicatorScreenWidget(),
    );
  }
}
