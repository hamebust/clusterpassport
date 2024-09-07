import 'package:bloc/bloc.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/create_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/delete_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/get_all_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/get_single_cluster_usecase.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/update_cluster_usecase.dart';
import 'package:equatable/equatable.dart';

part 'cluster_state.dart';

class ClusterCubit extends Cubit<ClusterState> {
  final CreateClusterUseCase createClusterUseCase;
  final DeleteSingleClusterUseCase deleteSingleClusterUseCase;
  final GetAllClustersUseCase getAllClusterUseCase;
  final GetSingleClusterUseCase getSingleClusterUseCase;
  final UpdateClusterUseCase updateClusterUseCase;

  ClusterCubit({
    required this.createClusterUseCase,
    required this.deleteSingleClusterUseCase,
    required this.getAllClusterUseCase,
    required this.getSingleClusterUseCase,
    required this.updateClusterUseCase,
  }) : super(ClusterInitial());

  // Método para crear un nuevo cluster
  Future<void> submitCluster({required ClusterEntity cluster}) async {
    try {
      await createClusterUseCase.createCluster(
        uid: cluster.uid,
        legalId: cluster.legalId,
        clustername: cluster.clustername,
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
      await updateClusterUseCase.updateCluster(cluster);
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
      final clusters = await getAllClusterUseCase.getAllClusters();
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
      final cluster = await getSingleClusterUseCase.getSingleCluster(clusterId);
      if (cluster != null) {
        emit(ClusterLoadedSingle(cluster: cluster));
      } else {
        emit(ClusterFailure(error: 'Cluster not found'));
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
      await deleteSingleClusterUseCase.deleteSingleCluster(clusterId);
      emit(ClusterDeleteSuccess()); // Emitir un estado de éxito en la eliminación
    } catch (e, stackTrace) {
      print('Error in deleteSingleCluster: $e');
      print(stackTrace);
      emit(ClusterFailure(error: e.toString()));
    }
  }
}
