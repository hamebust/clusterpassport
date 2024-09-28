import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class UsecaseClusterUpdateCluster {
  final ClusterRepository clusterRepository;

  UsecaseClusterUpdateCluster({required this.clusterRepository});

  Future<void> updateCluster(ClusterEntity cluster) async {
    // Actualizar en el repositorio remoto
    await clusterRepository.clusteRemoteDataSourceUpdate(cluster);

    // Actualizar en la base de datos local
    await clusterRepository.clusteLocalDataSourceUpdate(cluster);
  }
}
