part of 'auth_cubit.dart';

/// Clase base abstracta para todos los estados de autenticación.
/// Extiende Equatable para facilitar la comparación de estados.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial del proceso de autenticación.
class AuthInitial extends AuthState {}

/// Estado que representa a un usuario autenticado.
class Authenticated extends AuthState {
  final String uid;

  /// Constructor para el estado de usuario autenticado.
  const Authenticated({required this.uid});

  @override
  List<Object?> get props => [uid];
}

/// Estado que representa a un usuario no autenticado.
class UnAuthenticated extends AuthState {}
