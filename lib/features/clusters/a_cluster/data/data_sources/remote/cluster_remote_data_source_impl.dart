import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/app/const/firebase_collection_const.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/models/cluster_model.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/remote/cluster_remote_data_source.dart';

class ClusterRemoteDataSourceImpl implements ClusterRemoteDataSource {
  final FirebaseFirestore fireStore;

  ClusterRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> createClusterRemote(ClusterEntity cluster) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final newCluster = ClusterModel.fromEntity(cluster).toDocument();

    try {
      await clusterCollection.doc(cluster.clusterUid).set(newCluster);
    } catch (e) {
      // Implement error handling
      print("Error creating cluster: $e");
      throw Exception("Error creating cluster");
    }
  }

  @override
  Future<void> updateClusterRemote(ClusterEntity cluster) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final updatedCluster = ClusterModel.fromEntity(cluster).toDocument();

    try {
      await clusterCollection.doc(cluster.clusterUid).update(updatedCluster);
    } catch (e) {
      // Implement error handling
      print("Error updating cluster: $e");
      throw Exception("Error updating cluster");
    }
  }

  @override
  Future<void> deleteClusterRemote(String clusterId) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);

    try {
      await clusterCollection.doc(clusterId).delete();
    } catch (e) {
      // Implement error handling
      print("Error deleting cluster: $e");
      throw Exception("Error deleting cluster");
    }
  }

  @override
  Future<ClusterEntity?> getClusterByIdRemote(String clusterId) async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final docSnapshot = await clusterCollection.doc(clusterId).get();

    if (docSnapshot.exists) {
      return ClusterModel.fromSnapshot(docSnapshot).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<List<ClusterEntity>> getAllClustersRemote() async {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    final querySnapshot = await clusterCollection.get();

    return querySnapshot.docs.map((doc) {
      return ClusterModel.fromSnapshot(doc).toEntity();
    }).toList();
  }

  /// Nuevo método para obtener un stream de un cluster por su ID
  @override
  Stream<ClusterEntity?> getClusterByIdStreamRemote(String clusterId) {
    final clusterCollection = fireStore.collection(FirebaseCollectionConst.clusters);
    
    return clusterCollection.doc(clusterId).snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return ClusterModel.fromSnapshot(docSnapshot).toEntity();
      } else {
        return null;
      }
    });
  }
}
