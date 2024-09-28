import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class UsecaseClusterGetSingleCluster {
  final ClusterRepository clusterRepository;

  UsecaseClusterGetSingleCluster({required this.clusterRepository});

  Future<ClusterEntity?> getSingleCluster(String clusterUid) async {
    // Obtiene el cluster desde el repositorio remoto
    final cluster =
        await clusterRepository.clusteLocalDataSourceGetById(clusterUid);

    // Si el cluster se encuentra, guardarlo en la base de datos local
    if (cluster != null) {
      await clusterRepository.clusteLocalDataSourceGetById(clusterUid);
    }

    return cluster;
  }
}
