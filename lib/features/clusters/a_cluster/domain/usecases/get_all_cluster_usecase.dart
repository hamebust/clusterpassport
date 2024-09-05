import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class GetAllClusterUsecase {
  final ClusterRepository repository;

  GetAllClusterUsecase({required this.repository});

  Future<List<ClusterEntity>> call() async {
    return repository.getAllClusters();
  }
}

