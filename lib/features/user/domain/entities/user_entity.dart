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

  /// Creates a new instance of [UserEntity].
  const UserEntity({
    this.username,
    this.email, 
    this.phoneNumber, 
    this.uid, 
    this.status, 
    this.profileUrl, 
    this.isOnline
  });

  @override
  List<Object?> get props => [
    username,
    email, 
    phoneNumber, 
    uid, 
    status, 
    profileUrl, 
    isOnline
  ];
}