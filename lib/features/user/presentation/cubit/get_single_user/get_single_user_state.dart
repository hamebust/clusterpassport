part of 'get_single_user_cubit.dart';

/// Estado base abstracto para la obtención de un solo usuario.
/// Extiende Equatable para permitir la fácil comparación de estados.
abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de comenzar la operación de obtención del usuario.
class GetSingleUserInitial extends GetSingleUserState {}

/// Estado que indica que se está cargando la información del usuario.
class GetSingleUserLoading extends GetSingleUserState {}

/// Estado que indica que la información del usuario se ha cargado con éxito.
class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity singleUser;

  /// Constructor para [GetSingleUserLoaded].
  const GetSingleUserLoaded({required this.singleUser});

  @override
  List<Object> get props => [singleUser];
}

/// Estado que indica que hubo un fallo al obtener la información del usuario.
class GetSingleUserFailure extends GetSingleUserState {}
