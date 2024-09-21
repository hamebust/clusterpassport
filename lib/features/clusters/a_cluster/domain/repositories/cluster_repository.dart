import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterRepository: Repositorio abstracto que define las operaciones CRUD para los Clusters.
abstract class ClusterRepository {
  // Operaciones remotas
  Future<void> clusterRemoteDataSourceCreate(ClusterEntity cluster);
  Future<void> clusteRemoteDataSourceUpdate(ClusterEntity cluster);
  Future<void> clusteRemoteDataSourceDelete(String clusterId);
  Future<List<ClusterEntity>> clusteRemoteDataSourceGetAll();

  // Operaciones locales
  Future<void> clusteLocalDataSourceCreate(ClusterEntity cluster);
  Future<void> clusteLocalDataSourceUpdate(ClusterEntity cluster);
  Future<void> clusteLocalDataSourceDelete(String clusterId);
  Future<List<ClusterEntity>> clusteLocalDataSourceGetAll();

  // Métodos comunes
  Future<ClusterEntity?> clusteLocalDataSourceGetById(String clusterId);
  Stream<ClusterEntity?> clusteLocalDataSourceGetByIdStream(String clusterId);
}
