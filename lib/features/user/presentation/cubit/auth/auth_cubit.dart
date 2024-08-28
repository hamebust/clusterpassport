import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/get_current_uid_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/is_sign_in_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/sign_out_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

/// [AuthCubit] maneja los estados de autenticación del usuario,
/// controlando si el usuario está autenticado, no autenticado, o si ocurre un error.
class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;

  /// Constructor de [AuthCubit] que inicializa los casos de uso necesarios
  /// para manejar la autenticación del usuario.
  AuthCubit({
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());

  /// Método que se llama al inicio de la aplicación para verificar el estado
  /// de autenticación del usuario.
  Future<void> appStarted() async {
    _handleAuthOperation(
      operation: () async {
        final isSignedIn = await isSignInUseCase.call();
        if (isSignedIn) {
          final uid = await getCurrentUidUseCase.call();
          emit(Authenticated(uid: uid));
        } else {
          emit(UnAuthenticated());
        }
      },
    );
  }

  /// Método que se llama cuando el usuario inicia sesión.
  Future<void> loggedIn() async {
    _handleAuthOperation(
      operation: () async {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      },
    );
  }

  /// Método que se llama cuando el usuario cierra sesión.
  Future<void> loggedOut() async {
    _handleAuthOperation(
      operation: () async {
        await signOutUseCase.call();
        emit(UnAuthenticated());
      },
    );
  }

  /// Método privado para manejar operaciones de autenticación con manejo centralizado de errores.
  Future<void> _handleAuthOperation({required Future<void> Function() operation}) async {
    try {
      await operation();
    } catch (e) {
      // En caso de un error, emitir el estado no autenticado y registrar el error
      print('Error in authentication operation: $e');
      emit(UnAuthenticated());
    }
  }
}
