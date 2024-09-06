import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// CreateClusterUseCase: Clase que encapsula la lógica de crear un cluster.
/// CreateClusterUseCase: Class that encapsulates the logic of creating a cluster.
class CreateClusterUseCase {
  final ClusterRepository clusterRepository;

  CreateClusterUseCase(this.clusterRepository);

  /// [createCluster] Crea un nuevo cluster en el repositorio.
  /// [createCluster] Creates a new cluster in the repository.
  ///
  /// [cluster] es el objeto `ClusterEntity` que representa el cluster a crear.
  /// [cluster] is the `ClusterEntity` object representing the cluster to create.
  ///
  /// Devuelve un `Future<void>`.
  Future<void> createCluster(ClusterEntity cluster) async {
    await clusterRepository.createCluster(cluster);
  }
}