part of 'auth_cubit.dart';

/// Clase base abstracta para todos los estados de autenticación.
/// Extiende Equatable para facilitar la comparación de estados.

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

/// Estado inicial del proceso de autenticación.
class Authenticated extends AuthState {
  final String uid;

  const Authenticated({required this.uid});
  @override
  List<Object> get props => [uid];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
