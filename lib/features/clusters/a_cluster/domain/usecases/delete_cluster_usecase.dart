import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class DeleteSingleClusterUseCase {
  final ClusterRepository clusterRepository;

  DeleteSingleClusterUseCase({required this.clusterRepository});

  Future<void> deleteSingleCluster(String clusterUid) async {
    // Eliminar del repositorio remoto (Firebase)
    await clusterRepository.deleteClusterRemote(clusterUid);

    // Eliminar de la base de datos local
    await clusterRepository.deleteClusterLocal(clusterUid);
  }
}
