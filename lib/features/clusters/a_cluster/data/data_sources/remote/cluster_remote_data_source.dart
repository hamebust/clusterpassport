import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterRemoteDataSource: Fuente de datos remota para los Clusters (por ejemplo, Firebase).
abstract class ClusterRemoteDataSource {
  Future<void> createClusterRemote(ClusterEntity cluster);
  Future<void> updateClusterRemote(ClusterEntity cluster);
  Future<void> deleteClusterRemote(String clusterId);
  Future<List<ClusterEntity>> getAllClustersRemote();
  Future<ClusterEntity?> getClusterByIdRemote(String clusterId);

  /// Nuevo método para obtener un stream de clusters
  Stream<ClusterEntity?> getClusterByIdStreamRemote(String clusterId);
}
