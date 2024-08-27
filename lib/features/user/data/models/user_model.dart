// ignore_for_file: annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  // ignore: overridden_fields
  final String? username;
  // ignore: overridden_fields
  final String? email;
  // ignore: overridden_fields
  final String? phoneNumber;
  // ignore: overridden_fields
  final bool? isOnline;
  // ignore: overridden_fields
  final String? uid;
  // ignore: overridden_fields
  final String? status;
  // ignore: overridden_fields
  final String? profileUrl;

  const UserModel({
    this.username,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.uid,
    this.status,
    this.profileUrl,
  }) : super(
    username: username,
    email: email,
    uid: uid,
    profileUrl: profileUrl,
    phoneNumber: phoneNumber,
    isOnline: isOnline,
    status: status
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        status: snap['status'],
        profileUrl: snap['profileUrl'],
        phoneNumber: snap['phoneNumber'],
        isOnline: snap['isOnline'],
        email: snap['email'],
        username: snap['username'],
        uid: snap['uid']
    );
  }


  Map<String, dynamic> toDocument() => {
    "status": status,
    "profileUrl": profileUrl,
    "phoneNumber": phoneNumber,
    "isOnline": isOnline,
    "email": email,
    "username": username,
    "uid": uid
  };
}