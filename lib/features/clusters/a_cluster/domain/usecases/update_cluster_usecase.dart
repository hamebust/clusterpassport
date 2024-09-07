import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// UpdateClusterUseCase: Clase que encapsula la lógica para actualizar un cluster.
/// UpdateClusterUseCase: Class that encapsulates the logic to update a cluster.
class UpdateClusterUseCase {
  final ClusterRepository clusterRepository;

  UpdateClusterUseCase({required this.clusterRepository,} );


  Future<void> updateCluster(ClusterEntity cluster) async {
    await clusterRepository.updateCluster(cluster);
  }
}