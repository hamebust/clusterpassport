import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class GetSingleClusterUsecase {
  final ClusterRepository repository;

  GetSingleClusterUsecase({required this.repository});

  Future<ClusterEntity?> call(String clusterId) async {
    return repository.getClusterById(clusterId);
  }
}
