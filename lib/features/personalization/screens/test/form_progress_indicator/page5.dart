import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_progress_controller.dart';

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('Page 5')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.completePage(4);
            //Get.to(() => Page3());
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
