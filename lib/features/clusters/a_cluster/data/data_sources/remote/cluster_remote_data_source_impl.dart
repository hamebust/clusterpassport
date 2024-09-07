import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/app/const/firebase_collection_const.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/models/cluster_model.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';


class ClusterRemoteDataSourceImpl implements ClusterRemoteDataSource {
  final FirebaseFirestore fireStore;

  ClusterRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> createCluster(ClusterEntity cluster) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final newCluster = ClusterModel.fromEntity(cluster).toDocument();

    try {
      await clusterCollection.doc(cluster.uid).set(newCluster);
    } catch (e) {
      // Implement error handling (logging, throwing exception)
      // ignore: avoid_print
      print("Error creating cluster: $e");
      throw Exception("Error creating cluster");
    }
  }

  @override
  Future<void> updateCluster(ClusterEntity cluster) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final updatedCluster = ClusterModel.fromEntity(cluster).toDocument();

    try {
      await clusterCollection.doc(cluster.uid).update(updatedCluster);
    } catch (e) {
      // Implement error handling (logging, throwing exception)
      print("Error updating cluster: $e");
      throw Exception("Error updating cluster");
    }
  }

  @override
  Future<void> deleteCluster(String clusterId) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);

    try {
      await clusterCollection.doc(clusterId).delete();
    } catch (e) {
      // Implement error handling (logging, throwing exception)
      print("Error deleting cluster: $e");
      throw Exception("Error deleting cluster");
    }
  }

  @override
  Future<ClusterEntity?> getClusterById(String clusterId) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final docSnapshot = await clusterCollection.doc(clusterId).get();

    if (docSnapshot.exists) {
      return ClusterModel.fromSnapshot(docSnapshot).toEntity();
    } else {
      return null;
    }
  }

  @override
  Stream<List<ClusterEntity>> getAllClusters() {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);

    return clusterCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ClusterModel.fromSnapshot(e).toEntity()).toList());
  }
}