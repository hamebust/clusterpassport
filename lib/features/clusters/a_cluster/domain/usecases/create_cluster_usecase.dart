import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/repositories/cluster_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cluster_passport/features/clusters/a_cluster/data/models/cluster_model.dart';

class CreateClusterUsecase {
  final ClusterRepository clusterRepository;

  CreateClusterUsecase({required this.clusterRepository});

  Future<void> createCluster({
    required String clusterUid,
    required String legalId,
    required String clusterName,
    required String description,
    required String clusterType, // "Physical" or "Legal"
    required Address address,
    required LatLng coordinates,
    List<String> administrators = const [],
    List<String> clients = const [],
    List<String> securityGuard = const [],
  }) async {
    try {
      // Validar el tipo de cluster antes de crear la entidad
      if (clusterType != 'Physical' && clusterType != 'Legal') {
        throw Exception('Invalid cluster type: $clusterType');
      }

      // Crear entidad de Cluster en función del tipo (ahora con clusterType validado)
      ClusterEntity cluster;
      if (clusterType == 'Physical') {
        cluster = ClusterEntity.createPhysicalCluster(
          clusterUid: clusterUid,
          legalId: legalId,
          clusterName: clusterName,
          description: description,
          address: address,
          coordinates: coordinates,
          administrators: administrators,
          clients: clients,
          securityGuard: securityGuard,
        );
      } else { // clusterType debe ser 'Legal' en este punto
        cluster = ClusterEntity.createLegalCluster(
          clusterUid: clusterUid,
          legalId: legalId,
          clusterName: clusterName,
          description: description,
          address: address,
          coordinates: coordinates,
          administrators: administrators,
          clients: clients,
          securityGuard: securityGuard,
        );
      }

      // Crear el ClusterModel desde la entidad para manejar Firebase (repositorio remoto)
      final clusterModel = ClusterModel.fromEntity(cluster);
      await clusterRepository.createClusterRemote(clusterModel);

      // Guardar también en la base de datos local
      await clusterRepository.createClusterLocal(clusterModel.toEntity());
    } catch (e) {
      print("Error creating cluster: $e");
      throw Exception("Error creating cluster");
    }
  }
}