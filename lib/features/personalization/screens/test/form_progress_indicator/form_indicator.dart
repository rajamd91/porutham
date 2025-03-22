import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/page1.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/progress_indicator_widget.dart';

import 'form_progress_controller.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const IndicatorScreenWidget(),
      initialBinding: BindingsBuilder(() {
        Get.put(FormController());
      }),
    );
  }
}

class IndicatorScreenWidget extends StatelessWidget {
  const IndicatorScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Form')),
      body: Column(
        children: [
          const ProgressIndicatorWidget(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const Page1());
                },
                child: const Text('Start Form'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
