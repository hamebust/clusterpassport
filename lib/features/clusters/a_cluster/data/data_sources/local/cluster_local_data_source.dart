import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterLocalDataSource: Fuente de datos local para los Clusters.
abstract class ClusterLocalDataSource {
  Future<void> clusteLocalDataSourceCreate(ClusterEntity cluster);
  Future<void> clusteLocalDataSourceUpdate(ClusterEntity cluster);
  Future<void> clusteLocalDataSourceDelete(String clusterId);
  Future<ClusterEntity?> clusteLocalDataSourceGetByIdLocal(String clusterId);
  Stream<ClusterEntity?> clusteLocalDataSourceGetByIdStreamLocal(
      String clusterId);
  Future<List<ClusterEntity>> clusteLocalDataSourceGetAll();
  Future<void> partialUpdateClusterLocal(
      String clusterId, Map<String, dynamic> updatedFields);
}
