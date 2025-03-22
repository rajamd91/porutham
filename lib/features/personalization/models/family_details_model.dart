import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyDetailModel {
  final String? id;
  final String familyType;
  final String familyStatus;
  final String fatherOccupation;
  final String motherOccupation;
  final String familyOrigin;
  final String noOfBrothers;
  final String brothersMarried;
  final String noOfSisters;
  final String sistersMarried;
  final String docId;

  FamilyDetailModel({
    this.id,
    required this.familyType,
    required this.familyStatus,
    required this.fatherOccupation,
    required this.motherOccupation,
    required this.familyOrigin,
    required this.noOfBrothers,
    required this.brothersMarried,
    required this.noOfSisters,
    required this.sistersMarried,
    required this.docId,
  });

  //String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

// static function to create on empty Family Detail model
  static FamilyDetailModel empty() => FamilyDetailModel(
        id: '',
        familyType: '',
        familyStatus: '',
        fatherOccupation: '',
        motherOccupation: '',
        familyOrigin: '',
        noOfBrothers: '',
        brothersMarried: '',
        noOfSisters: '',
        sistersMarried: '',
        docId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FamilyType': familyType,
      'FamilyStatus': familyStatus,
      'FatherOccupation': fatherOccupation,
      'MotherOccupation': motherOccupation,
      'FamilyOrigin': familyOrigin,
      'NoOfBrothers': noOfBrothers,
      'BrothersMarried': brothersMarried,
      'NoOfSisters': noOfSisters,
      'SistersMarried': sistersMarried,
      'DocId': docId,
    };
  }

  factory FamilyDetailModel.fromMap(Map<String, dynamic> data) {
    return FamilyDetailModel(
      id: data['Id'] as String,
      familyType: data['FamilyType'] as String,
      familyStatus: data['FamilyStatus'] as String,
      fatherOccupation: data['FatherOccupation'] as String,
      motherOccupation: data['MotherOccupation'] as String,
      familyOrigin: data['FamilyOrigin'] as String,
      noOfBrothers: data['NoOfBrothers'] as String,
      brothersMarried: data['BrothersMarried'] as String,
      noOfSisters: data['NoOfSisters'] as String,
      sistersMarried: data['SistersMarried'] as String,
      docId: data['DocId'] as String,
    );
  }

  factory FamilyDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return FamilyDetailModel(
        id: document.id,
        familyType: data['FamilyType'] ?? '',
        familyStatus: data['FamilyStatus'] ?? '',
        fatherOccupation: data['FatherOccupation'] ?? '',
        motherOccupation: data['MotherOccupation'] ?? '',
        familyOrigin: data['FamilyOrigin'] ?? '',
        noOfBrothers: data['NoOfBrothers'] ?? '',
        brothersMarried: data['BrothersMarried'] ?? '',
        noOfSisters: data['NoOfSisters'] ?? '',
        sistersMarried: data['SistersMarried'] ?? '',
        docId: data['DocId'] ?? '',
      );
    } else {
      return FamilyDetailModel.empty();
    }
  }

  /// Factory constructor to create an Family DetailModel from a DocumentSnapshot
  factory FamilyDetailModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FamilyDetailModel(
      id: snapshot.id,
      familyType: data['FamilyType'] ?? '',
      familyStatus: data['FamilyStatus'] ?? '',
      fatherOccupation: data['FatherOccupation'] ?? '',
      motherOccupation: data['MotherOccupation'] ?? '',
      familyOrigin: data['FamilyOrigin'] ?? '',
      noOfBrothers: data['NoOfBrothers'] ?? '',
      brothersMarried: data['BrothersMarried'] ?? '',
      noOfSisters: data['NoOfSisters'] ?? '',
      sistersMarried: data['SistersMarried'] ?? '',
      docId: data['DocId'] ?? '',
    );
  }

  @override
  String toString() {
    return ''; //'$street,$fatherOccupation,$familyStatus,$postalCode,$familyType';
  }
}
