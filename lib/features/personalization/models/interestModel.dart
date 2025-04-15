import 'package:cloud_firestore/cloud_firestore.dart';

class InterestModel {
  final String? profileId;
  final String name;
  final String date;

  InterestModel({
    required this.profileId,
    required this.name,
    required this.date,
  });

// static function to create on empty InterestModel model
  static InterestModel empty() => InterestModel(
        profileId: '',
        name: '',
        date: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'ProfileId': profileId,
      'Name': name,
      'Date': date,
    };
  }

  factory InterestModel.fromMap(Map<String, dynamic> data) {
    return InterestModel(
      profileId: data['ProfileId'] as String,
      name: data['Name'] as String,
      date: data['Date'] as String,
    );
  }

  factory InterestModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return InterestModel(
        profileId: data['ProfileId'] ?? '',
        name: data['Name'] ?? '',
        date: data['Date'] ?? '',
      );
    } else {
      return InterestModel.empty();
    }
  }

  /// Factory constructor to create an InterestModel from a DocumentSnapshot
  factory InterestModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return InterestModel(
      profileId: data['ProfileId'] ?? '',
      name: data['Name'] ?? '',
      date: data['Date'] ?? '',
    );
  }
}
