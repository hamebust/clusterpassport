

import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// UpdateClusterUseCase: Clase que encapsula la lógica para actualizar un cluster.
/// UpdateClusterUseCase: Class that encapsulates the logic to update a cluster.
class UpdateClusterUseCase {
  final ClusterRepository clusterRepository;

  UpdateClusterUseCase(this.clusterRepository);

  /// [updateCluster] Actualiza un cluster existente.
  /// [updateCluster] Updates an existing cluster.
  ///
  /// [cluster] es el objeto `ClusterEntity` con los datos actualizados del cluster.
  /// [cluster] is the `ClusterEntity` object with the updated cluster data.
  Future<void> updateCluster(ClusterEntity cluster) async {
    await clusterRepository.updateCluster(cluster);
  }
}