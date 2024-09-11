import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class UpdateClusterUsecase {
  final ClusterRepository clusterRepository;

  UpdateClusterUsecase({required this.clusterRepository});

  Future<void> updateCluster(ClusterEntity cluster) async {
    // Actualizar en el repositorio remoto
    await clusterRepository.updateClusterRemote(cluster);

    // Actualizar en la base de datos local
    await clusterRepository.updateClusterLocal(cluster);
  }
}
