import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/create_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/delete_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/get_all_clusters_remote_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/get_single_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/update_cluster_usecase.dart';
import 'package:equatable/equatable.dart';

part 'cluster_state.dart';

class ClusterCubit extends Cubit<ClusterState> {
  final CreateClusterUsecase createClusterUsecase;
  final DeleteSingleClusterUsecase deleteSingleClusterUsecase;
  final GetAllClustersRemoteUsecase getAllClusterUsecase;
  final GetSingleClusterUsecase getSingleClusterUsecase;
  final UpdateClusterUsecase updateClusterUsecase;

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
        legalId: cluster.legalId,
        clusterName: cluster.clusterName,
        description: cluster.description,
        type: cluster.type,
        address: cluster.address,
        coordinates: cluster.coordinates,
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
