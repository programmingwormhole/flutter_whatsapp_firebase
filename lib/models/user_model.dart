import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? profilePicture;
  int? verified;
  String? phoneNumber;
  String? status;
  String? uid;

  UserModel({
    this.phoneNumber,
    this.name,
    this.uid,
    this.profilePicture,
    this.status,
    this.verified,
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot['name'],
      phoneNumber: snapshot['phone_number'],
      profilePicture: snapshot['profile_picture'],
      status: snapshot['status'],
      uid: snapshot['uid'],
    );
  }
}
