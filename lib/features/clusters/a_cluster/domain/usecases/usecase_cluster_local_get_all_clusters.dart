import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

/// UsecaseClusterRemoteGetAllClusters: Clase que encapsula la lógica para obtener todos los clusters
/// desde el repositorio local (sin interactuar con la base de datos remota).
class UsecaseClusterLocalGetAllClusters {
  final ClusterRepository clusterRepository;

  UsecaseClusterLocalGetAllClusters({required this.clusterRepository});

  /// Obtiene todos los clusters desde el repositorio local.
  Future<List<ClusterEntity>> clusteLocalDataSourceGetAll() async {
    return await clusterRepository.clusteLocalDataSourceGetAll();
  }
}
