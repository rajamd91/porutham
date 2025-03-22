import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';

final db = FirebaseFirestore.instance;
final userId = AuthenticationRepository.instance.authUser!.uid;
// var documentRef = db.doc('Users/userId/BioData/ProfessionDetails');

final userDocRef = db.collection("users").doc("userId");

// Access the sub-collection "orders" within that user document

final ordersCollectionRef = userDocRef.collection("BioData");

// Get a specific order document within the sub-collection

final specificOrderRef = ordersCollectionRef.doc("BasicDetails");

// Read the specific order document

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextButton(onPressed: test1, child: Text('Click')),
      ),
    );
  }
}

test1() {
  var ttt =
      specificOrderRef.get().then((DocumentSnapshot documentSnapshot) async {
    if (await documentSnapshot.exists) {
      print('Document exists on the database');
    } else {
      print('No Document Found ');
    }
  });
  print('Final $ttt');
}

// Assuming you have a collection called "users" and a sub-collection "orders" within each user document

// Get a reference to the user document
