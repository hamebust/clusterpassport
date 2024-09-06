import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// GetSingleClusterUseCase: Clase que encapsula la lógica para obtener un solo cluster por su ID.
/// GetSingleClusterUseCase: Class that encapsulates the logic to get a single cluster by its ID.
class GetSingleClusterUseCase {
  final ClusterRepository clusterRepository;

  GetSingleClusterUseCase(this.clusterRepository);

  /// [getSingleCluster] Obtiene un solo cluster por su ID.
  /// [getSingleCluster] Gets a single cluster by its ID.
  ///
  /// [clusterId] es el ID del cluster a obtener.
  /// [clusterId] is the ID of the cluster to get.
  ///
  /// Devuelve un `Future<ClusterEntity?>` que puede ser nulo si el cluster no existe.
  /// Returns a `Future<ClusterEntity?>` that can be null if the cluster does not exist.
  Future<ClusterEntity?> getSingleCluster(String clusterId) async {
    return await clusterRepository.getClusterById(clusterId);
  }
}