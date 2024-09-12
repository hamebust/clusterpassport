import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterRepository: Repositorio abstracto que define las operaciones CRUD para los Clusters.
abstract class ClusterRepository {
  // Operaciones remotas
  Future<void> createClusterRemote(ClusterEntity cluster);
  Future<void> updateClusterRemote(ClusterEntity cluster);
  Future<void> deleteClusterRemote(String clusterId);
  Future<List<ClusterEntity>> getAllClustersRemote();
  
  // Operaciones locales
  Future<void> createClusterLocal(ClusterEntity cluster);
  Future<void> updateClusterLocal(ClusterEntity cluster);
  Future<void> deleteClusterLocal(String clusterId);
  Future<List<ClusterEntity>> getAllClustersLocal();

  // Métodos comunes
  Future<ClusterEntity?> getClusterById(String clusterId);
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId);
}
