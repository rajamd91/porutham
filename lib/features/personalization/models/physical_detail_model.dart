import 'package:cloud_firestore/cloud_firestore.dart';

class PhysicalDetailModel {
  final String? id;
  final String physicalStatus;
  final String height;
  final String weight;
  final String color;
  final String bodyType;
  final String docId;

  PhysicalDetailModel({
    this.id,
    required this.physicalStatus,
    required this.height,
    required this.weight,
    required this.color,
    required this.bodyType,
    required this.docId,
  });

// static function to create on empty Physical Detail model
  static PhysicalDetailModel empty() => PhysicalDetailModel(
        id: '',
        physicalStatus: '',
        height: '',
        weight: '',
        color: '',
        bodyType: '',
        docId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'PhysicalStatus': physicalStatus,
      'Height': height,
      'Weight': weight,
      'Color': color,
      'BodyType': bodyType,
      'DocId': docId,
    };
  }

  factory PhysicalDetailModel.fromMap(Map<String, dynamic> data) {
    return PhysicalDetailModel(
      id: data['Id'] as String,
      physicalStatus: data['PhysicalStatus'] as String,
      height: data['Height'] as String,
      weight: data['Weight'] as String,
      color: data['Color'] as String,
      bodyType: data['BodyType'] as String,
      docId: data['DocId'] as String,
    );
  }

  factory PhysicalDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return PhysicalDetailModel(
        id: document.id,
        physicalStatus: data['PhysicalStatus'] ?? '',
        height: data['Height'] ?? '',
        weight: data['Weight'] ?? '',
        color: data['Color'] ?? '',
        bodyType: data['BodyType'] ?? '',
        docId: data['DocId'] ?? '',
      );
    } else {
      return PhysicalDetailModel.empty();
    }
  }

  /// Factory constructor to create an Physical DetailModel from a DocumentSnapshot
  factory PhysicalDetailModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return PhysicalDetailModel(
      id: snapshot.id,
      physicalStatus: data['PhysicalStatus'] ?? '',
      height: data['Height'] ?? '',
      weight: data['Weight'] ?? '',
      color: data['Color'] ?? '',
      bodyType: data['BodyType'] ?? '',
      docId: data['DocId'] ?? '',
    );
  }

  // @override
  // String toString() {
  //   return ''; //'$street,$weight,$height,$postalCode,$physicalStatus';
  // }
}
