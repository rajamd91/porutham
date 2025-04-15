import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poruththam_app/features/personalization/models/basic_detail_model.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';
import 'package:poruththam_app/features/personalization/screens/test/gmail_sent.dart';
import '../../../features/personalization/models/user_model.dart';
import '../authentication/authentication_repository.dart';

/// Repository class for user related operations
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //final String recipientMail = '';
  //final String subject='';
  //final String message='';

  /// save details of interested by user
  Future<void> saveInterestedRecord(String recipientMail, String subject,
      String messageText, String profileId, String name) async {
    sendGmail(recipientMail, subject, messageText);
    try {
      final DateTime date = DateTime.now();
      final String msg = "$name($profileId) is Interested in your profile";
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('SentInterest')
          .add({
        "ProfileId": profileId,
        "Name": name,
        "Date": date,
        "Message": msg
      });
    } on FirebaseException catch (e) {
      //throw TFirebaseException(e.code).message;
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Send Email Function
  void sendGmail(
      String recipientMail, String subject, String messageText) async {
    // final documentSnapshot = await _db
    //     .collection('Users')
    //     .doc(AuthenticationRepository.instance.authUser?.uid)
    //     .get();
    //
    // var snapshot = BioDataModel.fromSnapshot(documentSnapshot);
    //
    // final currentUserName = snapshot.name.toString();
    // final String currentUserProfileId = snapshot.profileId.toString();
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'tamilislammatrimony@gmail.com';
    String password = 'dkrr xpip zdxt kcso';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
          ..from = Address(username, 'Tamil Islam Matrimony')
          ..recipients.add(recipientMail)
          //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
          //..bccRecipients.add(Address('bccAddress@example.com'))
          ..subject = subject
          ..text = messageText
        //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"
        ;

    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Message sent: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Message not sent.');
      }
      for (var p in e.problems) {
        if (kDebugMode) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    //await connection.send(equivalentMessage);

    // close the connection
    await connection.close();
  }

  /// Function to create Profile Id
  Future<String> genarateUserId() async {
    var profileId = '';
    final documentSnapshot = await _db.collection("Admin").doc('admin').get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      var value = await data!['ProfileId'] as int;
      value = value + 1;
      profileId = value.toString();
    }
    profileId = BioDataModel.generateProfileId(profileId);
    return profileId;
  }

  /// Function to save user data in to FireStore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      //throw TFirebaseException(e.code).message;
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  ///Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  ///Function to fetch user bioData details based on user ID.
  Future<BioDataModel> fetchUserBioDataDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return BioDataModel.fromSnapshot(documentSnapshot);
      } else {
        return BioDataModel.empty();
      }
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Update any field in specific users collection.
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Update Admin Data in Firestore
  Future<void> updateAdmin(Map<String, dynamic> json) async {
    try {
      await _db.collection('Admin').doc('admin').update(json);
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Function to Update user data in FireStore.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Function to remove user data from FireStore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Upload Any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, sTackrace) {
      Get.snackbar("Error", "Something went wrong.Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      //print(error.toString());
    });
  }

  /// Step 2 - Fetch All Users OR User Details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    var value = '';
    final documentSnapshot = await _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      value = data!['Gender'].toString();
      print(value);
    }

    final snapshot = await _db
        .collection("Users")
        .where('Gender', isNotEqualTo: value)
        .get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  /// Fetch All User's BioData Equal to opposite Gender of the current User
  Future<List<BioDataModel>> allUserBioData() async {
    var value = '';
    final documentSnapshot = await _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      value = data!['Gender'].toString();
      print(value);
    }

    final snapshot = await _db
        .collection("Users")
        .where('Gender', isNotEqualTo: value)
        .get();
    final userData =
        snapshot.docs.map((e) => BioDataModel.fromSnapshot(e)).toList();
    return userData;
  }

  /// Fetch Selected User BioData by Profile Id
  Future<BioDataModel> singleUserBioData(String profileId) async {
    // var value = '';
    // final documentSnapshot = await _db
    //     .collection("Users")
    //     .doc(AuthenticationRepository.instance.authUser?.uid)
    //     .get();
    // if (documentSnapshot.exists) {
    //   Map<String, dynamic>? data = documentSnapshot.data();
    //   value = data!['Gender'].toString();
    //   print(value);
    // }
    //var profileId = '';
    final snapshot = await _db
        .collection("Users")
        .where('ProfileId', isEqualTo: profileId)
        .get();
    final BioDataModel userData =
        snapshot.docs.map((e) => BioDataModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }
}
