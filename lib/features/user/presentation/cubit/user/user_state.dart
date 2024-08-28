part of 'user_cubit.dart';

/// Estado base abstracto para la gestión de usuarios.
/// Extiende Equatable para permitir la fácil comparación de estados.
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de comenzar cualquier operación de usuario.
class UserInitial extends UserState {}

/// Estado que indica que la información de usuarios está siendo cargada.
class UserLoading extends UserState {}

/// Estado que indica que la información de usuarios ha sido cargada exitosamente.
class UserLoaded extends UserState {
  final List<UserEntity> users;

  /// Constructor para [UserLoaded].
  const UserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

/// Estado que indica que ocurrió un fallo al gestionar la información de usuarios.
class UserFailure extends UserState {
  final String error;

  /// Constructor para [UserFailure].
  const UserFailure({required this.error});

  @override
  List<Object> get props => [error];
}