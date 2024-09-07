import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_sources..dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class ClusterRepositoryImpl implements ClusterRepository {
  final ClusterLocalDataSource localDataSource;

  ClusterRepositoryImpl({required this.localDataSource});

  @override
  Future<void> createCluster(ClusterEntity cluster) async {
    await localDataSource.createCluster(cluster);
  }

  @override
  Future<ClusterEntity?> getClusterById(String clusterId) async {
    return await localDataSource.getClusterById(clusterId);
  }

  @override
  Future<List<ClusterEntity>> getAllClusters() async {
    return await localDataSource.getAllClusters();
  }

  @override
  Future<void> updateCluster(ClusterEntity cluster) async {
    await localDataSource.updateCluster(cluster);
  }

  @override
  Future<void> deleteCluster(String clusterId) async {
    await localDataSource.deleteCluster(clusterId);
  }

  @override
  Future<void> partialUpdateCluster(String clusterId, Map<String, dynamic> updatedFields) async {
    await localDataSource.partialUpdateCluster(clusterId, updatedFields);
  }

  @override
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId) {
    return localDataSource.getClusterByIdStream(clusterId);
  }
}
