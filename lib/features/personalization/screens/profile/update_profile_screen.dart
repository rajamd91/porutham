import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';
import 'package:poruththam_app/features/personalization/screens/profile/selected_profile_screen.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/profile_card_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final _userRepo = Get.put(UserRepository());
    final controller = Get.put(ProfileController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    //var ttt = _userRepo.generateProfileId();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left_solid)),
        title:
            Text(tProfile, style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
        child: FutureBuilder<List<BioDataModel>>(
          future: controller.getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      final BioDataModel bioData = snapshot.data![index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(
                                () => SelectedProfileScreen(bioData: bioData)),
                            child: TProfileCard(
                              image: '${snapshot.data![index].profilePicture},',
                              profileId: '${snapshot.data![index].profileId},',
                              name: '${snapshot.data![index].fullName},',
                              age:
                                  '${DateTime.now().difference(DateFormat("dd-MM-yyyy").parse(snapshot.data![index].birthDate)).inDays ~/ 365} Yrs,',
                              height: '${snapshot.data![index].height},',
                              religion: snapshot.data![index].religion,
                              division: '${snapshot.data![index].division},',
                              city: '${snapshot.data![index].city},',
                              motherTongue:
                                  '${snapshot.data![index].motherTongue},',
                              email: snapshot.data![index].email,
                            ),
                          )
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
