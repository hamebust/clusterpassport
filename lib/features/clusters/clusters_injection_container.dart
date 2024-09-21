import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source_impl.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source_impl.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/repositories/cluster_repository_impl.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/create_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/delete_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/get_all_clusters_remote_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/get_single_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/update_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/presentation/cubits/cluster/cluster_cubit.dart';
import 'package:cluster_passport/main_injection_container.dart';

Future<void> clustersInjectionContainer() async {
  sl.registerFactory<ClusterCubit>(() => ClusterCubit(
        createClusterUsecase: sl(),
        deleteSingleClusterUsecase: sl(),
        getAllClusterUsecase: sl(),
        getSingleClusterUsecase: sl(),
        updateClusterUsecase: sl(),
      ));

  // Registra el caso de uso para crear el Cluster
  sl.registerLazySingleton<CreateClusterUsecase>(
      () => CreateClusterUsecase(clusterRepository: sl()));

  // Registra el caso de uso para eliminar un usuario por su ID
  sl.registerLazySingleton<DeleteSingleClusterUsecase>(
      () => DeleteSingleClusterUsecase(clusterRepository: sl()));

  // registra el caso de uso para obtener todos los usuarios
  sl.registerLazySingleton<GetAllClustersRemoteUsecase>(
      () => GetAllClustersRemoteUsecase(clusterRepository: sl()));

  // Registra el caso de uso para obtener un solo usuario por su ID
  sl.registerLazySingleton<GetSingleClusterUsecase>(
      () => GetSingleClusterUsecase(clusterRepository: sl()));

  // Registra el caso de uso para actualizar la información de un usuario
  sl.registerLazySingleton<UpdateClusterUsecase>(
      () => UpdateClusterUsecase(clusterRepository: sl()));

  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<ClusterRepository>(
      () => ClusterRepositoryImpl(
            clusterLocalDataSource: sl(), // Asegúrate de que ClusterLocalDataSource también esté registrado
            clusterRemoteDataSource: sl(),
          ));

  // * DATA SOURCES INJECTION

  // Registro de la fuente de datos remota (Firebase)
  sl.registerLazySingleton<ClusterRemoteDataSource>(
      () => ClusterRemoteDataSourceImpl(
            fireStore: sl.call(),
          ));
  
  // Registro de la fuente de datos local (SQLite)
  sl.registerLazySingleton<ClusterLocalDataSource>(
      () => ClusterLocalDataSourceImpl()); 
}
