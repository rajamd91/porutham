import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/page5.dart';

import 'form_progress_controller.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Page 4')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.completePage(3);
            Get.to(() => const Page5());
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
