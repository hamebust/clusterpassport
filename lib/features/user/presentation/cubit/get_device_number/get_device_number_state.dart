part of 'get_device_number_cubit.dart';

/// Estado base abstracto para la obtención de números de contacto.
/// Extiende Equatable para permitir la fácil comparación de estados.
abstract class GetDeviceNumberState extends Equatable {
  const GetDeviceNumberState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de que comience la operación.
class GetDeviceNumberInitial extends GetDeviceNumberState {}

/// Estado que indica que se está cargando la información de contacto.
class GetDeviceNumberLoading extends GetDeviceNumberState {}

/// Estado que indica que los números de contacto se han cargado con éxito.
class GetDeviceNumberLoaded extends GetDeviceNumberState {
  final List<ContactEntity> contacts;

  /// Constructor para [GetDeviceNumberLoaded].
  const GetDeviceNumberLoaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

/// Estado que indica que hubo un fallo al obtener los números de contacto.
class GetDeviceNumberFailure extends GetDeviceNumberState {}
