import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source.dart';

/// ClusterRepositoryImpl: Implementación del repositorio para manejar las fuentes de datos locales y remotas.
class ClusterRepositoryImpl implements ClusterRepository {
  final ClusterLocalDataSource clusterLocalDataSource;
  final ClusterRemoteDataSource clusterRemoteDataSource;

  ClusterRepositoryImpl({
    required this.clusterLocalDataSource,
    required this.clusterRemoteDataSource,
  });

  // Operaciones Remotas
  @override
  Future<void> clusterRemoteDataSourceCreate(ClusterEntity cluster) async {
    await clusterRemoteDataSource.clusterRemoteDataSourceCreate(cluster);
  }

  @override
  Future<void> clusteRemoteDataSourceUpdate(ClusterEntity cluster) async {
    await clusterRemoteDataSource.clusteRemoteDataSourceUpdate(cluster);
  }

  @override
  Future<void> clusteRemoteDataSourceDelete(String clusterId) async {
    await clusterRemoteDataSource.clusteRemoteDataSourceDelete(clusterId);
  }

  @override
  Future<List<ClusterEntity>> clusteRemoteDataSourceGetAll() async {
    return await clusterRemoteDataSource.clusteRemoteDataSourceGetAll();
  }

  // Operaciones Locales
  @override
  Future<void> clusteLocalDataSourceCreate(ClusterEntity cluster) async {
    await clusterLocalDataSource.clusteLocalDataSourceCreate(cluster);
  }

  @override
  Future<void> clusteLocalDataSourceUpdate(ClusterEntity cluster) async {
    await clusterLocalDataSource.clusteLocalDataSourceUpdate(cluster);
  }

  @override
  Future<void> clusteLocalDataSourceDelete(String clusterId) async {
    await clusterLocalDataSource.clusteLocalDataSourceDelete(clusterId);
  }

  @override
  Future<List<ClusterEntity>> clusteLocalDataSourceGetAll() async {
    return await clusterLocalDataSource.clusteLocalDataSourceGetAll();
  }

  // Métodos comunes
  @override
  Future<ClusterEntity?> clusteLocalDataSourceGetById(String clusterId) async {
    return await clusterLocalDataSource
        .clusteLocalDataSourceGetByIdLocal(clusterId);
  }

  @override
  Stream<ClusterEntity?> clusteLocalDataSourceGetByIdStream(String clusterId) {
    return clusterLocalDataSource
        .clusteLocalDataSourceGetByIdStreamLocal(clusterId);
  }
}
