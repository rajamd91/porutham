import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poruththam_app/utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = "";
  String _name = "";
  String _gender = "";
  String _dob = "";
  String _martial = "";
  String _relation = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });

    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_uid)
        .collection('BioData')
        .doc('BasicDetails')
        .get();

    _name = userDoc.get('Name');
    _gender = userDoc.get('Gender');
    _dob = userDoc.get('BirthDate');
    _martial = userDoc.get('MaritalStatus');
    _relation = userDoc.get('ProfileCreater');
  }

  @override
  Widget build(BuildContext context) {
    //final themeChange=Provider.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $_name',
                style: const TextStyle(
                    color: TColors.dark, fontWeight: FontWeight.bold)),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text('Gender: $_gender',
                style: const TextStyle(
                    color: TColors.dark, fontWeight: FontWeight.bold)),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text('BirthDate: $_dob',
                style: const TextStyle(
                    color: TColors.dark, fontWeight: FontWeight.bold)),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text('MartialStatus: $_martial',
                style: const TextStyle(
                    color: TColors.dark, fontWeight: FontWeight.bold)),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text('Relation: $_relation',
                style: const TextStyle(
                    color: TColors.dark, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
