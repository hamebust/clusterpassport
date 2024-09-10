import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterLocalDataSource: Fuente de datos local para los Clusters.
abstract class ClusterLocalDataSource {
  Future<void> createCluster(ClusterEntity cluster);
  Future<void> updateCluster(ClusterEntity cluster);
  Future<void> deleteCluster(String clusterId);
  Future<ClusterEntity?> getClusterById(String clusterId);
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId);
  Future<List<ClusterEntity>> getAllClusters();
  Future<void> partialUpdateCluster(String clusterId, Map<String, dynamic> updatedFields);
}
