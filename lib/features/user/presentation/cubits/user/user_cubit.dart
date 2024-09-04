import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/get_all_users_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/update_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

/// [UserCubit] maneja la lógica de negocio relacionada con la obtención y actualización
/// de la información de usuarios, y emite los estados correspondientes para reflejar el progreso
/// y resultado de las operaciones.
class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  /// Constructor de [UserCubit].
  /// Inicializa el estado en [UserInitial].
  UserCubit({
    required this.updateUserUseCase,
    required this.getAllUsersUseCase,
  }) : super(UserInitial());

  /// Obtiene todos los usuarios del repositorio.
  /// Emitirá estados de carga, éxito o fallo según corresponda.
  Future<void> getAllUsers() async {
    emit(UserLoading());

    try {
      final streamResponse = getAllUsersUseCase.call();
      await for (final users in streamResponse) {
        emit(UserLoaded(users: users));
      }
    } catch (e, stackTrace) {
      print('Error in getAllUsers: $e');
      print(stackTrace);
      emit(UserFailure(error: e.toString()));
    }
  }

  /// Actualiza la información de un usuario.
  /// En caso de error, emitirá [UserFailure].
  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
      // Se puede emitir un estado de éxito aquí si es necesario.
    } catch (e, stackTrace) {
      print('Error in updateUser: $e');
      print(stackTrace);
      emit(UserFailure(error: e.toString()));
    }
  }
}