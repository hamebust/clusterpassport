part of 'cluster_cubit.dart';

sealed class ClusterState extends Equatable {
  const ClusterState();

  @override
  List<Object?> get props => [];
}

class ClusterInitial extends ClusterState {}

class ClusterLoading extends ClusterState {}

class ClusterLoaded extends ClusterState {
  final List<ClusterEntity> clusters;

  const ClusterLoaded({required this.clusters});

  @override
  List<Object> get props => [clusters];
}

class ClusterLoadedSingle extends ClusterState {
  final ClusterEntity cluster;

  const ClusterLoadedSingle({required this.cluster});

  @override
  List<Object> get props => [cluster];
}

class ClusterSuccess extends ClusterState {}

class ClusterFailure extends ClusterState {
  final String error;

  const ClusterFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// Estado que representa el éxito al eliminar un cluster
class ClusterDeleteSuccess extends ClusterState {}
