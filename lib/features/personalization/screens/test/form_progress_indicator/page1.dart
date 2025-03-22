import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/page2.dart';
import 'package:poruththam_app/features/personalization/screens/test/form_progress_indicator/progress_indicator_widget.dart';
import 'form_progress_controller.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: Column(
        children: [
          const ProgressIndicatorWidget(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                controller.completePage(0);
                Get.to(() => const Page2());
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}

// Similarly, create Page3, Page4, and Page5...
