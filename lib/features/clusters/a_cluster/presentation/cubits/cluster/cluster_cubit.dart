import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_create_single_cluster.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_delete_single_cluster.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_remote_get_all_clusters.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_get_single_cluster.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/usecase_cluster_update_cluster.dart';
import 'package:equatable/equatable.dart';

part 'cluster_state.dart';

class ClusterCubit extends Cubit<ClusterState> {
  final UsecaseClusterCreateSingleCluster createClusterUsecase;
  final UsecaseClusterDeleteSingleCluster deleteSingleClusterUsecase;
  final UsecaseClusterRemoteGetAllClusters getAllClusterUsecase;
  final UsecaseClusterGetSingleCluster getSingleClusterUsecase;
  final UsecaseClusterUpdateCluster updateClusterUsecase;

  ClusterCubit({
    required this.createClusterUsecase,
    required this.deleteSingleClusterUsecase,
    required this.getAllClusterUsecase,
    required this.getSingleClusterUsecase,
    required this.updateClusterUsecase,
  }) : super(ClusterInitial());

  // Método para crear un nuevo cluster
  Future<void> submitCluster({required ClusterEntity cluster}) async {
    try {
      await createClusterUsecase.createCluster(
        clusterUid: cluster.clusterUid,
        clusterLegalId: cluster.clusterLegalId,
        clusterName: cluster.clusterName,
        clusterDescription: cluster.clusterDescription,
        clusterType: cluster.clusterType,
        clusterAddress: cluster.clusterAddress,
        clusterCoordinates: cluster.clusterCoordinates,
      );
      emit(ClusterSuccess());
    } catch (e, stackTrace) {
      print('Error in submitCluster: $e');
      print(stackTrace);
      emit(ClusterFailure(error: e.toString()));
    }
  }

  // Método para actualizar un cluster existente
  Future<void> updateCluster({required ClusterEntity cluster}) async {
    try {
      await updateClusterUsecase.updateCluster(cluster);
      emit(ClusterSuccess());
    } catch (e, stackTrace) {
      print('Error in updateCluster: $e');
      print(stackTrace);
      emit(ClusterFailure(error: e.toString()));
    }
  }

  // Método para obtener todos los clusters
  Future<void> getAllClusters() async {
    emit(ClusterLoading());

    try {
      final clusters = await getAllClusterUsecase.getAllClusters();
      emit(ClusterLoaded(clusters: clusters));
    } catch (e, stackTrace) {
      print('Error in getAllClusters: $e');
      print(stackTrace);
      emit(ClusterFailure(error: e.toString()));
    }
  }

  // Método para obtener un solo cluster
  Future<void> getSingleCluster(String clusterId) async {
    emit(ClusterLoading());

    try {
      final cluster = await getSingleClusterUsecase.getSingleCluster(clusterId);
      if (cluster != null) {
        emit(ClusterLoadedSingle(cluster: cluster));
      } else {
        emit(const ClusterFailure(error: 'Cluster not found'));
      }
    } catch (e, stackTrace) {
      print('Error in getSingleCluster: $e');
      print(stackTrace);
      emit(ClusterFailure(error: e.toString()));
    }
  }

  // Método para eliminar un cluster
  Future<void> deleteSingleCluster(String clusterId) async {
    emit(ClusterLoading());

    try {
      await deleteSingleClusterUsecase.deleteSingleCluster(clusterId);
      emit(
          ClusterDeleteSuccess()); // Emitir un estado de éxito en la eliminación
    } catch (e, stackTrace) {
      print('Error in deleteSingleCluster: $e');
      print(stackTrace);
      emit(ClusterFailure(error: e.toString()));
    }
  }
}
