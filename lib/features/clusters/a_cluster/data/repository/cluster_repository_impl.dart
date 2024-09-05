import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';

class ClusterRepositoryImpl implements ClusterRepository {
  final ClusterRemoteDataSource remoteDataSource;

  ClusterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createCluster(ClusterEntity cluser) async => remoteDataSource.createCluster(cluser);


  @override
  Future<void> updateCluster(ClusterEntity user) async => remoteDataSource.updateCluster();
  
  @override
  Future<void> deleteCluster(String clusterId) {
    // TODO: implement deleteCluster
    throw UnimplementedError();
  }
  
  @override
  Future<List<ClusterEntity>> getAllClusters() {
    // TODO: implement getAllClusters
    throw UnimplementedError();
  }
  
  @override
  Future<ClusterEntity?> getClusterById(String clusterId) {
    // TODO: implement getClusterById
    throw UnimplementedError();
  }
  
  @override
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId) {
    // TODO: implement getClusterByIdStream
    throw UnimplementedError();
  }

}