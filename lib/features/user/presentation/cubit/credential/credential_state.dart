part of 'credential_cubit.dart';

/// Estado base abstracto para todos los estados de credenciales.
/// Extiende Equatable para permitir la fácil comparación de estados.
abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial del proceso de credenciales.
class CredentialInitial extends CredentialState {}

/// Estado que indica que se está realizando el proceso de credenciales.
class CredentialLoading extends CredentialState {
  @override
  List<Object> get props => [];
}


/// Estado que indica que el código SMS ha sido enviado al usuario.
class CredentialPhoneAuthSmsCodeSent extends CredentialState {}

/// Estado que indica que se espera la información de perfil del usuario.
class CredentialPhoneAuthProfileInfo extends CredentialState {}

/// Estado que indica que la operación de credenciales fue exitosa.
class CredentialSuccess extends CredentialState {
  @override
  List<Object> get props => [];
}

/// Estado que indica que se ha recibido el código SMS del usuario.
class CredentialPhoneAuthSmsCodeReceived extends CredentialState {
  @override
  List<Object> get props => [];
}

/// Estado que indica que ocurrió un error durante el proceso de credenciales.
class CredentialFailure extends CredentialState {
  final String message;

  const CredentialFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
