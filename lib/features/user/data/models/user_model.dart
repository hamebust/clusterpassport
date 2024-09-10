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
  // ignore: overridden_fields
  final List<String>? myClusters;

  const UserModel({
    this.username,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.uid,
    this.status,
    this.profileUrl,
    this.myClusters = const [], // Inicializa la lista vacía.
  }) : super(
          username: username,
          email: email,
          uid: uid,
          profileUrl: profileUrl,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          status: status,
          myClusters: myClusters ?? const [], // Asegura que sea una lista no nula.
        );

  /// Método de fábrica para crear una instancia de `UserModel` desde un snapshot de Firestore.
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      status: snap['status'],
      profileUrl: snap['profileUrl'],
      phoneNumber: snap['phoneNumber'],
      isOnline: snap['isOnline'],
      email: snap['email'],
      username: snap['username'],
      uid: snap['uid'],
      myClusters: List<String>.from(snap['myClusters'] ?? []), // Maneja myClusters.
    );
  }

  /// Convierte el modelo a un documento de Firestore.
  Map<String, dynamic> toDocument() => {
        "status": status,
        "profileUrl": profileUrl,
        "phoneNumber": phoneNumber,
        "isOnline": isOnline,
        "email": email,
        "username": username,
        "uid": uid,
        "myClusters": myClusters, // Incluye myClusters.
      };
}
