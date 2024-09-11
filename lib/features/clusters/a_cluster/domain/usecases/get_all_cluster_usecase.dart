import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// GetAllClustersUsecase: Clase que encapsula la lógica para obtener todos los clusters
/// desde el repositorio remoto (sin interactuar con la base de datos local).
class GetAllClustersUsecase {
  final ClusterRepository clusterRepository;

  GetAllClustersUsecase({required this.clusterRepository});

  /// Obtiene todos los clusters desde el repositorio remoto.
  ///
  /// Devuelve un `Future<List<ClusterEntity>>` con una lista de todos los clusters.
  Future<List<ClusterEntity>> getAllClusters() async {
    return await clusterRepository.getAllClustersRemote();
  }
}
