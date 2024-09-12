import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterLocalDataSource: Fuente de datos local para los Clusters.
abstract class ClusterLocalDataSource {
  Future<void> createClusterLocal(ClusterEntity cluster);
  Future<void> updateClusterLocal(ClusterEntity cluster);
  Future<void> deleteClusterLocal(String clusterId);
  Future<ClusterEntity?> getClusterByIdLocal(String clusterId);
  Stream<ClusterEntity?> getClusterByIdStreamLocal(String clusterId);
  Future<List<ClusterEntity>> getAllClustersLocal();
  Future<void> partialUpdateClusterLocal(String clusterId, Map<String, dynamic> updatedFields);
}
