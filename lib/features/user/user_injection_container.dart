import 'package:cluster_passport/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:cluster_passport/features/user/data/data_sources/remote/user_remote_data_source_impl.dart';
import 'package:cluster_passport/features/user/data/repository/user_repository_impl.dart';
import 'package:cluster_passport/features/user/domain/repositories/user_repository.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/get_current_uid_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/is_sign_in_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/sign_in_with_phone_number_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/sign_out_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/credential/verify_phone_number_usecsae.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/create_user_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/get_all_users_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/get_device_number_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/get_single_user_usecase.dart';
import 'package:cluster_passport/features/user/domain/usescases/user/update_user_usecase.dart';
import 'package:cluster_passport/features/user/presentation/cubits/auth/auth_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubits/credential/credential_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubits/get_device_number/get_device_number_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubits/get_single_user/get_single_user_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubits/user/user_cubit.dart';
import 'package:cluster_passport/main_injection_container.dart';

/// Configura la inyección de dependencias para los Cubits, Use Cases, Repositorios y Data Sources
/// relacionados con la gestión de usuarios en la aplicación.
Future<void> userInjectionContainer() async {
  // * CUBITS INJECTION
  // Registro de Cubits en el Service Locator (sl)

  // Registra AuthCubit para manejar la autenticación del usuario
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        getCurrentUidUseCase: sl(),
        isSignInUseCase: sl(),
        signOutUseCase: sl(),
      ));

  // Registra UserCubit para gestionar la obtención y actualización de usuarios
  sl.registerFactory<UserCubit>(() => UserCubit(
        updateUserUseCase: sl(),
        getAllUsersUseCase: sl(),
      ));

  // Registra GetSingleUserCubit para obtener un único usuario basado en su UID
  sl.registerFactory<GetSingleUserCubit>(() => GetSingleUserCubit(
        getSingleUserUseCase: sl(),
      ));

  // Registra CredentialCubit para manejar el proceso de verificación de credenciales del usuario
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
        createUserUseCase: sl(),
        signInWithPhoneNumberUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
      ));

  // Registra GetDeviceNumberCubit para obtener los números de teléfono del dispositivo
  sl.registerFactory<GetDeviceNumberCubit>(() => GetDeviceNumberCubit(
        getDeviceNumberUseCase: sl(),
      ));

  // * USE CASES INJECTION
  // Registro de Use Cases en el Service Locator (sl)

  // Registra el caso de uso para obtener el UID actual del usuario
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl()));

  // Registra el caso de uso para verificar si el usuario está autenticado
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl()));

  // Registra el caso de uso para cerrar sesión
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl()));

  // Registra el caso de uso para crear un nuevo usuario
  sl.registerLazySingleton<CreateUserUseCase>(
      () => CreateUserUseCase(repository: sl()));

  // Registra el caso de uso para obtener todos los usuarios
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl()));

  // Registra el caso de uso para actualizar la información de un usuario
  sl.registerLazySingleton<UpdateUserUseCase>(
      () => UpdateUserUseCase(repository: sl()));

  // Registra el caso de uso para obtener un único usuario por UID
  sl.registerLazySingleton<GetSingleUserUseCase>(
      () => GetSingleUserUseCase(repository: sl()));

  // Registra el caso de uso para iniciar sesión con número de teléfono
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
      () => SignInWithPhoneNumberUseCase(repository: sl()));

  // Registra el caso de uso para verificar el número de teléfono
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
      () => VerifyPhoneNumberUseCase(repository: sl()));

  // Registra el caso de uso para obtener los números de teléfono del dispositivo
  sl.registerLazySingleton<GetDeviceNumberUseCase>(
      () => GetDeviceNumberUseCase(repository: sl()));

  // * REPOSITORY & DATA SOURCES INJECTION
  // Registro de Repositorios y Data Sources en el Service Locator (sl)

  // Registra el repositorio de usuario que interactúa con el data source remoto
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));

  // Registra el data source remoto que interactúa con la base de datos y autenticación
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
        auth: sl(),
        fireStore: sl(),
      ));
}