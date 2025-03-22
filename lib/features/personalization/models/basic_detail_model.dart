import 'package:cloud_firestore/cloud_firestore.dart';

class BasicDetailModel {
  final String? id;
  final String name;
  final String gender;
  final String birthDate;
  final String motherTongue;
  final String maritalStatus;
  final String profileCreater;
  final String docId;

  BasicDetailModel({
    this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.motherTongue,
    required this.maritalStatus,
    required this.profileCreater,
    required this.docId,
  });

// static function to create on empty BasicDetailModel model
  static BasicDetailModel empty() => BasicDetailModel(
        id: '',
        name: '',
        gender: '',
        birthDate: '',
        motherTongue: '',
        maritalStatus: '',
        profileCreater: '',
        docId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Gender': gender,
      'BirthDate': birthDate,
      'MotherTongue': motherTongue,
      'MaritalStatus': maritalStatus,
      'ProfileCreater': profileCreater,
      'DocId': docId,
    };
  }

  factory BasicDetailModel.fromMap(Map<String, dynamic> data) {
    return BasicDetailModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      gender: data['Gender'] as String,
      birthDate: data['BirthDate'] as String,
      motherTongue: data['MotherTongue'] as String,
      maritalStatus: data['MaritalStatus'] as String,
      profileCreater: data['ProfileCreater'] as String,
      docId: data['DocId'] as String,
    );
  }

  factory BasicDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BasicDetailModel(
        id: data['Id'],
        name: data['Name'] ?? '',
        gender: data['Gender'] ?? '',
        birthDate: data['BirthDate'] ?? '',
        motherTongue: data['MotherTongue'] ?? '',
        maritalStatus: data['MaritalStatus'] ?? '',
        profileCreater: data['ProfileCreater'] ?? '',
        docId: data['DocId'] ?? '',
      );
    } else {
      return BasicDetailModel.empty();
    }
  }

  /// Factory constructor to create an BasicDetailModel from a DocumentSnapshot
  factory BasicDetailModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BasicDetailModel(
      id: data['Id'],
      name: data['Name'] ?? '',
      gender: data['Gender'] ?? '',
      birthDate: data['BirthDate'] ?? '',
      motherTongue: data['MotherTongue'] ?? '',
      maritalStatus: data['MaritalStatus'] ?? '',
      profileCreater: data['ProfileCreater'] ?? '',
      docId: data['DocId'] ?? '',
    );
  }
}
