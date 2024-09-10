import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source.dart';

/// ClusterRepositoryImpl: Implementación del repositorio para manejar las fuentes de datos locales y remotas.
class ClusterRepositoryImpl implements ClusterRepository {
  final ClusterLocalDataSource localDataSource;
  final ClusterRemoteDataSource remoteDataSource;

  ClusterRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  // Operaciones Remotas
  @override
  Future<void> createClusterRemote(ClusterEntity cluster) async {
    await remoteDataSource.createCluster(cluster);
  }

  @override
  Future<void> updateClusterRemote(ClusterEntity cluster) async {
    await remoteDataSource.updateCluster(cluster);
  }

  @override
  Future<void> deleteClusterRemote(String clusterId) async {
    await remoteDataSource.deleteCluster(clusterId);
  }

  @override
  Future<List<ClusterEntity>> getAllClustersRemote() async {
    return await remoteDataSource.getAllClusters();
  }

  // Operaciones Locales
  @override
  Future<void> createClusterLocal(ClusterEntity cluster) async {
    await localDataSource.createCluster(cluster);
  }

  @override
  Future<void> updateClusterLocal(ClusterEntity cluster) async {
    await localDataSource.updateCluster(cluster);
  }

  @override
  Future<void> deleteClusterLocal(String clusterId) async {
    await localDataSource.deleteCluster(clusterId);
  }

  // Métodos comunes
  @override
  Future<ClusterEntity?> getClusterById(String clusterId) async {
    return await localDataSource.getClusterById(clusterId);
  }

  @override
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId) {
    return localDataSource.getClusterByIdStream(clusterId);
  }
}
