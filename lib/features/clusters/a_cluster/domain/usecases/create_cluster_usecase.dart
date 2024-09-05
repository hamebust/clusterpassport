import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class CreateClusterUseCase {
  final ClusterRepository repository;

  CreateClusterUseCase({required this.repository});

  Future<void> call(ClusterEntity cluster) async {
    return repository.createCluster(cluster);
  }
}
