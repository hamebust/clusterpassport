import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterRemoteDataSource: Fuente de datos remota para los Clusters (por ejemplo, Firebase).
abstract class ClusterRemoteDataSource {
  Future<void> clusterRemoteDataSourceCreate(ClusterEntity cluster);
  Future<void> clusteRemoteDataSourceUpdate(ClusterEntity cluster);
  Future<void> clusteRemoteDataSourceDelete(String clusterId);
  Future<List<ClusterEntity>> clusteRemoteDataSourceGetAll();
  Future<ClusterEntity?> clusteLocalDataSourceGetByIdRemote(String clusterId);

  /// Nuevo método para obtener un stream de clusters
  Stream<ClusterEntity?> clusteLocalDataSourceGetByIdStreamRemote(
      String clusterId);
}
