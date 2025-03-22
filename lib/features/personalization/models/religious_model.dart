import 'package:cloud_firestore/cloud_firestore.dart';

class ReligiousDetailModel {
  final String? id;
  final String religion;
  final String madhab;
  final String division;
  final String jamath;
  final String follows;
  final String religiousValues;
  final String docId;

  ReligiousDetailModel({
    this.id,
    required this.religion,
    required this.madhab,
    required this.division,
    required this.jamath,
    required this.follows,
    required this.religiousValues,
    required this.docId,
  });

// static function to create on empty ProfessionDetail model
  static ReligiousDetailModel empty() => ReligiousDetailModel(
        id: '',
        religion: '',
        madhab: '',
        division: '',
        jamath: '',
        follows: '',
        religiousValues: '',
        docId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Religion': religion,
      'Madhab': madhab,
      'Division': division,
      'Jamath': jamath,
      'Follows': follows,
      'Religious Values': religiousValues,
      'DocId': docId,
    };
  }

  factory ReligiousDetailModel.fromMap(Map<String, dynamic> data) {
    return ReligiousDetailModel(
      id: data['Id'] as String,
      religion: data['Religion'] as String,
      madhab: data['Madhab'] as String,
      division: data['Division'] as String,
      jamath: data['Jamath'] as String,
      follows: data['Follows'] as String,
      religiousValues: data['Religious Values'] as String,
      docId: data['DocId'] as String,
    );
  }

  factory ReligiousDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ReligiousDetailModel(
        id: data['Id'] ?? '',
        religion: data['Religion'] ?? '',
        madhab: data['Madhab'] ?? '',
        division: data['Division'] ?? '',
        jamath: data['Jamath'] ?? '',
        follows: data['Follows'] ?? '',
        religiousValues: data['Religious Values'] ?? '',
        docId: data['DocId'] ?? '',
      );
    } else {
      return ReligiousDetailModel.empty();
    }
  }

  /// Factory constructor to create an BasicDetailModel from a DocumentSnapshot
  factory ReligiousDetailModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ReligiousDetailModel(
      id: data['Id'] ?? '',
      religion: data['Religion'] ?? '',
      madhab: data['Madhab'] ?? '',
      division: data['Division'] ?? '',
      jamath: data['Jamath'] ?? '',
      follows: data['Follows'] ?? '',
      religiousValues: data['Religious Values'] ?? '',
      docId: data['DocId'] ?? '',
    );
  }
}
