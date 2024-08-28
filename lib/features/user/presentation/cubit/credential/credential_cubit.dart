import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/sign_in_with_phone_number_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/verify_phone_number_usecsae.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/create_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'credential_state.dart';

/// [CredentialCubit] maneja los estados relacionados con el proceso
/// de autenticación del usuario usando su número de teléfono.
class CredentialCubit extends Cubit<CredentialState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final CreateUserUseCase createUserUseCase;

  CredentialCubit({
    required this.signInWithPhoneNumberUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.createUserUseCase,
  }) : super(CredentialInitial());

  /// Verifica el número de teléfono del usuario y emite el estado correspondiente.
  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    _handleOperation(
      operation: () async {
        await verifyPhoneNumberUseCase.call(phoneNumber);
        emit(CredentialPhoneAuthSmsCodeSent());
      },
    );
  }

  /// Verifica el código SMS y emite el estado correspondiente.
  Future<void> submitSmsCode({required String smsCode}) async {
    _handleOperation(
      operation: () async {
        await signInWithPhoneNumberUseCase.call(smsCode);
        emit(CredentialPhoneAuthProfileInfo());
      },
    );
  }

  /// Envía la información de perfil del usuario y emite el estado correspondiente.
  Future<void> submitProfileInfo({required UserEntity user}) async {
    _handleOperation(
      operation: () async {
        await createUserUseCase.call(user);
        emit(CredentialSuccess());
      },
    );
  }

  /// Método privado que maneja operaciones y captura errores comunes.
  Future<void> _handleOperation({required Future<void> Function() operation}) async {
    try {
      await operation();
    } on SocketException {
      emit(CredentialFailure(message: 'Error de red. Verifica tu conexión.'));
    } catch (e) {
      emit(CredentialFailure(message: 'Ocurrió un error inesperado: $e'));
    }
  }
}
