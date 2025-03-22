import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form_progress_controller.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController controller = Get.find();
    return Column(
      children: [
        LinearProgressIndicator(
          value: controller.progress,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 10),
        Text('Progress: ${(controller.progress * 100).toStringAsFixed(0)}%'),
        const SizedBox(height: 10),
        Obx(
          () =>
              Text('Completed Pages: ${controller.completedPages.join(', ')}'),
        ),
        Text('Completed Pages: ${controller.completedPages.join(', ')}'),
      ],
    );
  }
}
