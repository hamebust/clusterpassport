import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/models/cluster_model.dart';

class UsecaseClusterCreateSingleCluster {
  final ClusterRepository clusterRepository;

  UsecaseClusterCreateSingleCluster({required this.clusterRepository});

  Future<void> createCluster({
    required String clusterUid,
    required String clusterLegalId,
    required String clusterName,
    required String clusterDescription,
    required String clusterType, // "Physical" or "Legal"
    required ClusterAddress clusterAddress,
    required LatLng clusterCoordinates,
    List<String> clusterAdministrators = const [],
    List<String> clusterClients = const [],
    List<String> clusterSecurityGuard = const [],
  }) async {
    try {
      // Validar el tipo de cluster antes de crear la entidad
      if (clusterType != 'Physical' && clusterType != 'Legal') {
        throw Exception('Invalid cluster type: $clusterType');
      }

      // Crear entidad de Cluster en función del tipo (ahora con clusterType validado)
      ClusterEntity cluster;
      if (clusterType == 'Physical') {
        cluster = ClusterEntity.clusterEntityCreatePhysical(
          clusterUid: clusterUid,
          clusterLegalId: clusterLegalId,
          clusterName: clusterName,
          clusterDescription: clusterDescription,
          clusterAddress: clusterAddress,
          clusterCoordinates: clusterCoordinates,
          clusterAdministrators: clusterAdministrators,
          clusterClients: clusterClients,
          clusterSecurityGuard: clusterSecurityGuard,
        );
      } else {
        // clusterType debe ser 'Legal' en este punto
        cluster = ClusterEntity.clusterEntityCreateLegal(
          clusterUid: clusterUid,
          clusterLegalId: clusterLegalId,
          clusterName: clusterName,
          clusterDescription: clusterDescription,
          clusterAddress: clusterAddress,
          clusterCoordinates: clusterCoordinates,
          clusterAdministrators: clusterAdministrators,
          clusterClients: clusterClients,
          clusterSecurityGuard: clusterSecurityGuard,
        );
      }

      // Crear el ClusterModel desde la entidad para manejar Firebase (repositorio remoto)
      final clusterModel = ClusterModel.fromEntity(cluster);
      await clusterRepository.clusterRemoteDataSourceCreate(clusterModel);

      // Guardar también en la base de datos local
      await clusterRepository
          .clusteLocalDataSourceCreate(clusterModel.toEntity());
    } catch (e) {
      print("Error creating cluster: $e");
      throw Exception("Error creating cluster");
    }
  }
}
