import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/page4.dart';

import 'form_progress_controller.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Page 3')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.completePage(2);
            Get.to(() => const Page4());
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
