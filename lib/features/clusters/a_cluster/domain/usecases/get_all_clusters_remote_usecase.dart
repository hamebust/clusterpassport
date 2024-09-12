import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// GetAllClustersRemoteUsecase: Clase que encapsula la lógica para obtener todos los clusters
/// desde el repositorio remoto (sin interactuar con la base de datos local).
class GetAllClustersRemoteUsecase {
  final ClusterRepository clusterRepository;

  GetAllClustersRemoteUsecase({required this.clusterRepository});

  /// Obtiene todos los clusters desde el repositorio remoto.
  Future<List<ClusterEntity>> getAllClusters() async {
    return await clusterRepository.getAllClustersRemote();
  }
}
