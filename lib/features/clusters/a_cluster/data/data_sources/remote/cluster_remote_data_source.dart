import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

abstract class ClusterRemoteDataSource {
  Future<void> createCluster(ClusterEntity cluster);
  Future<void> updateCluster(ClusterEntity cluster);
  Future<void> deleteCluster(String clusterId);
  Future<ClusterEntity?> getClusterById(String clusterId);
  Stream<List<ClusterEntity>> getAllClusters();
}