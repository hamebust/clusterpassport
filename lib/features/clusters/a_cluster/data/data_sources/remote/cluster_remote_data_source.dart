import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterRemoteDataSource: Fuente de datos remota para los Clusters (por ejemplo, Firebase).
abstract class ClusterRemoteDataSource {
  Future<void> createCluster(ClusterEntity cluster);
  Future<void> updateCluster(ClusterEntity cluster);
  Future<void> deleteCluster(String clusterId);
  Future<List<ClusterEntity>> getAllClusters();
  Future<ClusterEntity?> getClusterById(String clusterId);

  /// Nuevo método para obtener un stream de clusters
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId);
}
