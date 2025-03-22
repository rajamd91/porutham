import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionDetailModel {
  final String? id;
  final String education;
  final String educationDetail;
  final String employedIn;
  final String occupation;
  final String occupationDetail;
  final String income;
  final String docId;

  ProfessionDetailModel({
    this.id,
    required this.education,
    required this.educationDetail,
    required this.employedIn,
    required this.occupation,
    required this.occupationDetail,
    required this.income,
    required this.docId,
  });

// static function to create on empty ProfessionDetail model
  static ProfessionDetailModel empty() => ProfessionDetailModel(
        id: '',
        education: '',
        educationDetail: '',
        employedIn: '',
        occupation: '',
        occupationDetail: '',
        income: '',
        docId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Education': education,
      'EducationDetail': educationDetail,
      'EmployedIn': employedIn,
      'Occupation': occupation,
      'OccupationDetail': occupationDetail,
      'Income': income,
      'DocId': docId,
    };
  }

  factory ProfessionDetailModel.fromMap(Map<String, dynamic> data) {
    return ProfessionDetailModel(
      id: data['Id'] as String,
      education: data['Education'] as String,
      educationDetail: data['EducationDetail'] as String,
      employedIn: data['EmployedIn'] as String,
      occupation: data['Occupation'] as String,
      occupationDetail: data['OccupationDetail'] as String,
      income: data['Income'] as String,
      docId: data['DocId'] as String,
    );
  }

  factory ProfessionDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProfessionDetailModel(
        id: document.id,
        education: data['Education'] ?? '',
        educationDetail: data['EducationDetail'] ?? '',
        employedIn: data['EmployedIn'] ?? '',
        occupation: data['Occupation'] ?? '',
        occupationDetail: data['OccupationDetail'] ?? '',
        income: data['Income'] ?? '',
        docId: data['DocId'] ?? '',
      );
    } else {
      return ProfessionDetailModel.empty();
    }
  }

  /// Factory constructor to create an BasicDetailModel from a DocumentSnapshot
  factory ProfessionDetailModel.fromDocumentSnapshot(
      DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProfessionDetailModel(
      id: snapshot.id,
      education: data['Name'] ?? '',
      educationDetail: data['Gender'] ?? '',
      employedIn: data['BirthDate'] ?? '',
      occupation: data['ProfileCreater'] ?? '',
      occupationDetail: data['MaritalStatus'] ?? '',
      income: data['Income'] ?? '',
      docId: data['DocId'] ?? '',
    );
  }
}
