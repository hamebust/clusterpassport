import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// GetAllClustersUseCase: Clase que encapsula la lógica para obtener todos los clusters.
/// GetAllClustersUseCase: Class that encapsulates the logic to get all clusters.
class GetAllClustersUseCase {
  final ClusterRepository clusterRepository;

  GetAllClustersUseCase({required this.clusterRepository});

  /// [getAllClusters] Obtiene todos los clusters del repositorio.
  /// [getAllClusters] Gets all clusters from the repository.
  ///
  /// Devuelve un `Future<List<ClusterEntity>>` con una lista de todos los clusters.
  /// Returns a `Future<List<ClusterEntity>>` with a list of all clusters.
  Future<List<ClusterEntity>> getAllClusters() async {
    return await clusterRepository.getAllClusters();
  }
}