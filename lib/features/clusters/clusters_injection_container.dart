import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source_impl.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source_impl.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/repositories/cluster_repository_impl.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_create_single_cluster.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_delete_single_cluster.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_remote_get_all_clusters.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_get_single_cluster.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_update_cluster.dart';
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
  sl.registerLazySingleton<UsecaseClusterCreateSingleCluster>(
      () => UsecaseClusterCreateSingleCluster(clusterRepository: sl()));

  // Registra el caso de uso para eliminar un usuario por su ID
  sl.registerLazySingleton<UsecaseClusterDeleteSingleCluster>(
      () => UsecaseClusterDeleteSingleCluster(clusterRepository: sl()));

  // registra el caso de uso para obtener todos los usuarios
  sl.registerLazySingleton<UsecaseClusterRemoteGetAllClusters>(
      () => UsecaseClusterRemoteGetAllClusters(clusterRepository: sl()));

  // Registra el caso de uso para obtener un solo usuario por su ID
  sl.registerLazySingleton<UsecaseClusterGetSingleCluster>(
      () => UsecaseClusterGetSingleCluster(clusterRepository: sl()));

  // Registra el caso de uso para actualizar la información de un usuario
  sl.registerLazySingleton<UsecaseClusterUpdateCluster>(
      () => UsecaseClusterUpdateCluster(clusterRepository: sl()));

  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<ClusterRepository>(() => ClusterRepositoryImpl(
        clusterLocalDataSource:
            sl(), // Asegúrate de que ClusterLocalDataSource también esté registrado
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
