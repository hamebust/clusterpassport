import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/user/domain/entities/contact_entity.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/get_device_number_usecase.dart';
import 'package:equatable/equatable.dart';

part 'get_device_number_state.dart';

/// [GetDeviceNumberCubit] maneja el estado relacionado con la obtención
/// de números de contacto desde el dispositivo.
class GetDeviceNumberCubit extends Cubit<GetDeviceNumberState> {
  final GetDeviceNumberUseCase getDeviceNumberUseCase;

  /// Constructor para [GetDeviceNumberCubit].
  /// Inicializa el estado en [GetDeviceNumberInitial].
  GetDeviceNumberCubit({required this.getDeviceNumberUseCase}) 
      : super(GetDeviceNumberInitial());

  /// Método que obtiene los números de contacto del dispositivo.
  Future<void> getDeviceNumber() async {
    emit(GetDeviceNumberLoading());  // Emitimos estado de carga al iniciar la operación
    try {
      // Llama al caso de uso para obtener los números de contacto
      final contactNumbers = await getDeviceNumberUseCase.call();
      emit(GetDeviceNumberLoaded(contacts: contactNumbers));
    } catch (e) {
      // Manejo de errores en caso de fallo durante la operación
      print('Error in getDeviceNumber: $e');
      emit(GetDeviceNumberFailure());
    }
  }
}
