import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/get_single_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'get_single_user_state.dart';

/// [GetSingleUserCubit] maneja la lógica de negocio para obtener la información de un solo usuario
/// y emite los estados correspondientes para reflejar el progreso y resultado de la operación.
class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;

  /// Constructor de [GetSingleUserCubit].
  /// Inicializa el estado en [GetSingleUserInitial].
  GetSingleUserCubit({required this.getSingleUserUseCase})
      : super(GetSingleUserInitial());

  /// Método que obtiene un solo usuario basado en el UID proporcionado.
  /// Emitirá estados de carga, éxito o fallo según corresponda.
  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());

    try {
      final streamResponse = getSingleUserUseCase.call(uid);
      await for (final users in streamResponse) {
        if (users.isNotEmpty) {
          emit(GetSingleUserLoaded(singleUser: users.first));
        } else {
          emit(GetSingleUserFailure());
        }
      }
    } catch (e) {
      print('Error in getSingleUser: $e');
      emit(GetSingleUserFailure());
    }
  }
}
