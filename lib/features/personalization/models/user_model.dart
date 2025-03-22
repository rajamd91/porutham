/*
   ======================
   Todo: Step -1 [Create Model]
   ======================
 */

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/formatters/formatter.dart';

/// Model class representing user data
class UserModel {
  // Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  String profileId;

  /// Constructor for user model
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.profileId,
  });
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Helper function to get the full name
  String get fullName => '$firstName $lastName';

  /// Helper function to format Phone Number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name in to first and last name.
  static List<String> nameParts(fullName) => fullName.split("");

  /// Static function to generate a user name from the full name
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split("");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    /// Combine first and last name
    String camelCaseUserName = "$firstName$lastName";

    /// Add "cwt_" prefix
    String userNameWithPrefix = "cwt_$camelCaseUserName";

    return userNameWithPrefix;
  }

  static String generateProfileId(String lastProfileId) {
    String profileIdd = lastProfileId;
    int currentYear = DateTime.now().year;
    profileIdd = 'TNM$currentYear$profileIdd';
    return profileIdd;
  }

  // static function to create on empty user model
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        email: '',
        profilePicture: '',
        profileId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'ProfileId': profileId,
    };
  }

  /// Step 1-Map User fetched from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        email: data["Email"] ?? '',
        firstName: data["FirstName"] ?? '',
        lastName: data["LastName"] ?? '',
        phoneNumber: data["PhoneNumber"] ?? '',
        userName: data["Username"] ?? '',
        profilePicture: data["ProfilePicture"] ?? '',
        profileId: data["ProfileId"] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
