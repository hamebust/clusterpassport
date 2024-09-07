import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// CreateClusterUseCase: Clase que encapsula la lógica de crear un cluster.
/// CreateClusterUseCase: Class that encapsulates the logic of creating a cluster.
class CreateClusterUseCase {
  final ClusterRepository clusterRepository;

  CreateClusterUseCase({required this.clusterRepository});

  /// Crea un nuevo cluster en el repositorio seleccionando el tipo (físico o jurídico).
  /// Creates a new cluster in the repository by selecting the type (physical or legal).
  ///
  /// [type] es el tipo de cluster: "Physical" o "Legal".
  /// [type] is the cluster type: "Physical" or "Legal".
  ///
  /// [clusterId] es el identificador único del cluster.
  /// [clusterId] is the unique identifier for the cluster.
  ///
  /// Devuelve un `Future<void>`.
  Future<void> createCluster({
    required String uid,
    required String legalId,
    required String clustername,
    required String description,
    required String type, // "Physical" or "Legal"
    required Address address,
    required LatLng coordinates,
  }) async {
    try {
      ClusterEntity cluster;

      // Selecciona el tipo de cluster y crea la instancia adecuada
      if (type == 'Physical') {
        cluster = ClusterEntity.createPhysicalCluster(
          uid: uid,
          legalId: legalId,
          clustername: clustername,
          description: description,
          address: address,
          coordinates: coordinates,
        );
      } else if (type == 'Legal') {
        cluster = ClusterEntity.createLegalCluster(
          uid: uid,
          legalId: legalId,
          clustername: clustername,
          description: description,
          address: address,
          coordinates: coordinates,
        );
      } else {
        throw Exception('Invalid cluster type: $type');
      }

      // Guarda el cluster en el repositorio
      await clusterRepository.createCluster(cluster);
    } catch (e) {
      print("Error creating cluster: $e");
      throw Exception("Error creating cluster");
    }
  }
}
