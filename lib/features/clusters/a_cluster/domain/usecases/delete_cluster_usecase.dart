
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// CreateClusterUseCase: Clase que encapsula la lógica de crear un cluster.
/// CreateClusterUseCase: Class that encapsulates the logic of creating a cluster.
class DeleteSingleClusterUseCase {
  final ClusterRepository clusterRepository;

  DeleteSingleClusterUseCase({required this.clusterRepository});

  Future<void> deleteSingleCluster(String clusterId) async {
    return clusterRepository.deleteCluster(clusterId);
  }
}
