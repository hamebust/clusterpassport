import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class DeleteSingleClusterUsecase {
  final ClusterRepository clusterRepository;

  DeleteSingleClusterUsecase({required this.clusterRepository});

  Future<void> deleteSingleCluster(String clusterUid) async {
    // Eliminar del repositorio remoto (Firebase)
    await clusterRepository.clusteRemoteDataSourceDelete(clusterUid);

    // Eliminar de la base de datos local
    await clusterRepository.clusteLocalDataSourceDelete(clusterUid);
  }
}
