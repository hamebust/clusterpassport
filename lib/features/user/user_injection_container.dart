import 'package:cluster_passport/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:cluster_passport/features/user/data/data_sources/remote/user_remote_data_source_impl.dart';
import 'package:cluster_passport/features/user/data/repositories/user_repository_impl.dart';
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
        getCurrentUidUsecase: sl(),
        isSignInUsecase: sl(),
        signOutUsecase: sl(),
      ));

  // Registra UserCubit para gestionar la obtención y actualización de usuarios
  sl.registerFactory<UserCubit>(() => UserCubit(
        updateUserUsecase: sl(),
        getAllUsersUsecase: sl(),
      ));

  // Registra GetSingleUserCubit para obtener un único usuario basado en su UID
  sl.registerFactory<GetSingleUserCubit>(() => GetSingleUserCubit(
        getSingleUserUsecase: sl(),
      ));

  // Registra CredentialCubit para manejar el proceso de verificación de credenciales del usuario
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
        createUserUsecase: sl(),
        signInWithPhoneNumberUsecase: sl(),
        verifyPhoneNumberUsecase: sl(),
      ));

  // Registra GetDeviceNumberCubit para obtener los números de teléfono del dispositivo
  sl.registerFactory<GetDeviceNumberCubit>(() => GetDeviceNumberCubit(
        getDeviceNumberUsecase: sl(),
      ));

  // * USE CASES INJECTION
  // Registro de Use Cases en el Service Locator (sl)

  // Registra el caso de uso para obtener el UID actual del usuario
  sl.registerLazySingleton<GetCurrentUidUsecase>(
      () => GetCurrentUidUsecase(repository: sl()));

  // Registra el caso de uso para verificar si el usuario está autenticado
  sl.registerLazySingleton<IsSignInUsecase>(
      () => IsSignInUsecase(repository: sl()));

  // Registra el caso de uso para cerrar sesión
  sl.registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(repository: sl()));

  // Registra el caso de uso para crear un nuevo usuario
  sl.registerLazySingleton<CreateUserUsecase>(
      () => CreateUserUsecase(repository: sl()));

  // Registra el caso de uso para obtener todos los usuarios
  sl.registerLazySingleton<GetAllUsersUsecase>(
      () => GetAllUsersUsecase(repository: sl()));

  // Registra el caso de uso para actualizar la información de un usuario
  sl.registerLazySingleton<UpdateUserUsecase>(
      () => UpdateUserUsecase(repository: sl()));

  // Registra el caso de uso para obtener un único usuario por UID
  sl.registerLazySingleton<GetSingleUserUsecase>(
      () => GetSingleUserUsecase(repository: sl()));

  // Registra el caso de uso para iniciar sesión con número de teléfono
  sl.registerLazySingleton<SignInWithPhoneNumberUsecase>(
      () => SignInWithPhoneNumberUsecase(repository: sl()));

  // Registra el caso de uso para verificar el número de teléfono
  sl.registerLazySingleton<VerifyPhoneNumberUsecase>(
      () => VerifyPhoneNumberUsecase(repository: sl()));

  // Registra el caso de uso para obtener los números de teléfono del dispositivo
  sl.registerLazySingleton<GetDeviceNumberUsecase>(
      () => GetDeviceNumberUsecase(repository: sl()));

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
