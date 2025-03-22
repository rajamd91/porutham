import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/page3.dart';

import 'form_progress_controller.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.completePage(1);
            Get.to(() => const Page3());
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
