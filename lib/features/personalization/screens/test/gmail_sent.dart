import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/common/widgets/appbar/appbar.dart';

import '../../../../data/repositories/user/user_repository.dart';

class SendGmail extends StatelessWidget {
  const SendGmail({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = Get.put(UserRepository());
    return Scaffold(
      appBar: const TAppBar(title: Text('Send Email'), showBackArrow: true),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            userRepo.sendGmail(
                'rajamd91@gmail.com', 'Noticed', 'Some one noticed you');
          },
          child: const Text('Send Email'),
        ),
      ),
    );
  }
}
