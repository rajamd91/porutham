import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../utils/formatters/formatter.dart';

/// Model class representing user data
class BioDataModel {
  // Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  final String name;
  final String gender;
  final String birthDate;
  final String motherTongue;
  final String maritalStatus;
  final String profileCreater;
  final String physicalStatus;
  final String height;
  final String weight;
  final String color;
  final String bodyType;
  final String education;
  final String educationDetail;
  final String employedIn;
  final String occupation;
  final String occupationDetail;
  final String income;
  final String familyType;
  final String familyStatus;
  final String fatherOccupation;
  final String motherOccupation;
  final String familyOrigin;
  final String noOfBrothers;
  final String brothersMarried;
  final String noOfSisters;
  final String sistersMarried;
  final String religion;
  final String madhab;
  final String division;
  final String jamath;
  final String follows;
  final String religiousValues;
  final String country;
  final String state;
  final String district;
  final String city;
  final String address;
  final String pincode;
  final String profileId;
  final String docId;

  /// Constructor for user model
  BioDataModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.motherTongue,
    required this.maritalStatus,
    required this.profileCreater,
    required this.physicalStatus,
    required this.height,
    required this.weight,
    required this.color,
    required this.bodyType,
    required this.education,
    required this.educationDetail,
    required this.employedIn,
    required this.occupation,
    required this.occupationDetail,
    required this.income,
    required this.familyType,
    required this.familyStatus,
    required this.fatherOccupation,
    required this.motherOccupation,
    required this.familyOrigin,
    required this.noOfBrothers,
    required this.brothersMarried,
    required this.noOfSisters,
    required this.sistersMarried,
    required this.religion,
    required this.madhab,
    required this.division,
    required this.jamath,
    required this.follows,
    required this.religiousValues,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    required this.pincode,
    required this.profileId,
    required this.docId,
  });

  calculateAge(String birth) {
    DateTime birthDate = DateFormat("dd-MM-yyyy").parse(birth);
    DateTime now = DateTime.now();
    (DateTime.now().difference(DateFormat("dd-MM-yyyy").parse(birth)).inDays ~/
            365)
        .toString();
    Duration age = now.difference(birthDate);
    int years = age.inDays ~/ 365;
    // int months = (age.inDays % 365) ~/ 30;
    // int days = ((age.inDays % 365) % 30);

    //myAge = '$years years, $months months, and $days days';
  }

  /// Helper function to get the full name
  String get fullName => '$firstName $lastName';

  static String generateProfileId(lastProfileId) {
    var profileIdd = lastProfileId;
    int currentYear = DateTime.now().year;
    profileIdd = 'TNM$currentYear$profileIdd';
    return profileIdd;
  }

  static BioDataModel empty() => BioDataModel(
        id: '',
        firstName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        email: '',
        profilePicture: '',
        name: '',
        gender: '',
        birthDate: '',
        motherTongue: '',
        maritalStatus: '',
        profileCreater: '',
        physicalStatus: '',
        height: '',
        weight: '',
        color: '',
        bodyType: '',
        education: '',
        educationDetail: '',
        employedIn: '',
        occupation: '',
        occupationDetail: '',
        income: '',
        familyType: '',
        familyStatus: '',
        fatherOccupation: '',
        motherOccupation: '',
        familyOrigin: '',
        noOfBrothers: '',
        brothersMarried: '',
        noOfSisters: '',
        sistersMarried: '',
        religion: '',
        madhab: '',
        division: '',
        jamath: '',
        follows: '',
        religiousValues: '',
        country: '',
        state: '',
        district: '',
        city: '',
        address: '',
        pincode: '',
        profileId: '',
        docId: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'LastProfileId': profileId,
    };
  }

  /// Step 1-Map User fetched from Firebase to BioDataModel
  factory BioDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BioDataModel(
        id: document.id,
        email: data["Email"] ?? '',
        firstName: data["FirstName"] ?? '',
        lastName: data["LastName"] ?? '',
        phoneNumber: data["PhoneNumber"] ?? '',
        userName: data["Username"] ?? '',
        profilePicture: data["ProfilePicture"] ?? '',
        name: data["Name"] ?? '',
        gender: data["Gender"] ?? '',
        birthDate: data["BirthDate"] ?? '',
        motherTongue: data["MotherTongue"] ?? '',
        maritalStatus: data["MaritalStatus"] ?? '',
        profileCreater: data["ProfileCreater"],
        physicalStatus: data["PhysicalStatus"],
        height: data["Height"],
        weight: data["Weight"],
        color: data["Color"],
        bodyType: data["BodyType"],
        education: data["Education"],
        educationDetail: data["EducationDetail"],
        employedIn: data["EmployedIn"],
        occupation: data["Occupation"],
        occupationDetail: data["OccupationDetail"],
        income: data["Income"],
        familyType: data["FamilyType"],
        familyStatus: data["FamilyStatus"],
        fatherOccupation: data["FatherOccupation"],
        motherOccupation: data["MotherOccupation"],
        familyOrigin: data["FamilyOrigin"],
        noOfBrothers: data["NoOfBrothers"],
        brothersMarried: data["BrothersMarried"],
        noOfSisters: data["NoOfSisters"],
        sistersMarried: data["SistersMarried"],
        religion: data["Religion"],
        madhab: data["Madhab"],
        division: data["Division"],
        jamath: data["Jamath"],
        follows: data["Follows"],
        religiousValues: data["Religious Values"],
        country: data["Country"],
        state: data["State"],
        district: data["District"],
        city: data["City"],
        address: data["Address"],
        pincode: data["PinCode"],
        profileId: data["ProfileId"],
        docId: data["DocId"],
      );
    } else {
      return BioDataModel.empty();
    }
  }
}
