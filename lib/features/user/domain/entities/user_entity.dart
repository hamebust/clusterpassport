import 'package:equatable/equatable.dart';

/// Represents a user entity with various attributes.
class UserEntity extends Equatable {

  /// The username of the user.
  final String? username;

  /// The email address of the user.
  final String? email;

  /// The phone number of the user.
  final String? phoneNumber;

  /// The unique identifier of the user.
  final String? uid;

  /// The status of the user (e.g., active, inactive).
  final String? status;

  /// The URL to the user's profile picture.
  final String? profileUrl;

  /// Indicates whether the user is online.
  final bool? isOnline;

  /// The list of clusters the user belongs to.
  /// UIDs of the clusters the user is associated with.
  final List<String>? myClusters; // Nueva variable para los UIDs de los clusters.

  /// Creates a new instance of [UserEntity].
  const UserEntity({
    this.username,
    this.email, 
    this.phoneNumber, 
    this.uid, 
    this.status, 
    this.profileUrl, 
    this.isOnline,
    this.myClusters = const [], // Inicializa la lista vacía por defecto.
  });

  @override
  List<Object?> get props => [
    username,
    email, 
    phoneNumber, 
    uid, 
    status, 
    profileUrl, 
    isOnline,
    myClusters, // Incluye la nueva variable en los props.
  ];
}
