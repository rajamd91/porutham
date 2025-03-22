import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class LocationDetailModel {
  final String? id;
  final String country;
  final String state;
  final String district;
  final String city;
  final String address;
  final String pincode;
  final String docId;

  LocationDetailModel({
    this.id,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    required this.pincode,
    required this.docId,
  });

  //String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

// static function to create on empty BasicDetail model
  static LocationDetailModel empty() => LocationDetailModel(
        id: '',
        country: '',
        state: '',
        district: '',
        city: '',
        address: '',
        pincode: '',
        docId: '',
      );

  /// convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Country': country,
      'State': state,
      'District': district,
      'City': city,
      'Address': address,
      'PinCode': pincode,
      'DocId': docId,
    };
  }

  factory LocationDetailModel.fromMap(Map<String, dynamic> data) {
    return LocationDetailModel(
      id: data['Id'] as String,
      country: data['Country'] as String,
      state: data['State'] as String,
      district: data['District'] as String,
      city: data['City'] as String,
      address: data['Address'] as String,
      pincode: data['PinCode'] as String,
      docId: data['DocId'] as String,
    );
  }

  factory LocationDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return LocationDetailModel(
        id: document.id,
        country: data['Country'] ?? '',
        state: data['State'] ?? '',
        district: data['District'] ?? '',
        city: data['City'] ?? '',
        address: data['Address'] ?? '',
        pincode: data['PinCode'] ?? '',
        docId: data['DocId'] ?? '',
      );
    } else {
      return LocationDetailModel.empty();
    }
  }

  /// Factory constructor to create an BasicDetailModel from a DocumentSnapshot
  factory LocationDetailModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return LocationDetailModel(
      id: snapshot.id,
      country: data['Country'] ?? '',
      state: data['State'] ?? '',
      district: data['District'] ?? '',
      city: data['City'] ?? '',
      address: data['Address'] ?? '',
      pincode: data['PinCode'] ?? '',
      docId: data['DocId'] ?? '',
    );
  }

  @override
  String toString() {
    return ''; //'$street,$city,$state,$postalCode,$country';
  }
}
