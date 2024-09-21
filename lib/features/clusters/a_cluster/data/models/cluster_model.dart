import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusterModel extends ClusterEntity {
  const ClusterModel({
    required super.clusterUid,
    required super.clusterLegalId,
    required super.clusterName,
    required super.clusterDescription,
    required super.clusterType,
    required super.clusterAddress,
    required super.clusterCoordinates,
    super.clusterAdministrators = const [],
    super.clusterClients = const [],
    super.clusterSecurityGuard = const [],
  });

  // Factory method para crear un ClusterModel desde un snapshot de Firebase.
  factory ClusterModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return ClusterModel(
      clusterUid: snap['clusterUid'],
      clusterLegalId: snap['clusterLegalId'] ?? '',
      clusterName: snap['clusterName'] ?? '',
      clusterDescription: snap['clusterDescription'] ?? '',
      clusterType: snap['clusterType'] ?? 'Physical',
      clusterAddress: ClusterAddress(
        clusterAddressStreetTypeAndName: snap['clusterAddressStreetTypeAndName'] ?? '',
        clusterAddressBuildingNumber: snap['clusterAddressBuildingNumber'] ?? '',
        clusterAddressApartmentOrFloor: snap['clusterAddressApartmentOrFloor'] ?? '',
        clusterAddressNeighborhood: snap['clusterAddressNeighborhood'] ?? '',
        clusterAddressPostalCode: snap['clusterAddressPostalCode'] ?? '',
        clusterAddressCity: snap['clusterAddressCity'] ?? '',
        state: snap['state'] ?? '',
        country: snap['country'] ?? '',
      ),
      clusterCoordinates: LatLng(
        snap['latitude'] ?? 0.0,
        snap['longitude'] ?? 0.0,
      ),
      clusterAdministrators: List<String>.from(snap['clusterAdministrators'] ?? []),
      clusterClients: List<String>.from(snap['clusterClients'] ?? []),
      clusterSecurityGuard: List<String>.from(snap['clusterSecurityGuard'] ?? []),
    );
  }

  // Método para convertir el modelo en un mapa para subir a Firebase.
  Map<String, dynamic> toDocument() => {
        "clusterUid": clusterUid,
        "clusterLegalId": clusterLegalId,
        "clusterName": clusterName,
        "clusterDescription": clusterDescription,
        "clusterType": clusterType,
        "clusterAddressStreetTypeAndName": clusterAddress.clusterAddressStreetTypeAndName,
        "clusterAddressBuildingNumber": clusterAddress.clusterAddressBuildingNumber,
        "clusterAddressApartmentOrFloor": clusterAddress.clusterAddressApartmentOrFloor,
        "clusterAddressNeighborhood": clusterAddress.clusterAddressNeighborhood,
        "clusterAddressPostalCode": clusterAddress.clusterAddressPostalCode,
        "clusterAddressCity": clusterAddress.clusterAddressCity,
        "state": clusterAddress.state,
        "country": clusterAddress.country,
        "latitude": clusterCoordinates.latitude,
        "longitude": clusterCoordinates.longitude,
        "clusterAdministrators": clusterAdministrators,
        "clusterClients": clusterClients,
        "clusterSecurityGuard": clusterSecurityGuard,
      };

  // Método de fábrica para crear un ClusterModel desde una entidad existente.
  factory ClusterModel.fromEntity(ClusterEntity cluster) {
    return ClusterModel(
      clusterUid: cluster.clusterUid,
      clusterLegalId: cluster.clusterLegalId,
      clusterName: cluster.clusterName,
      clusterDescription: cluster.clusterDescription,
      clusterType: cluster.clusterType,
      clusterAddress: cluster.clusterAddress,
      clusterCoordinates: cluster.clusterCoordinates,
      clusterAdministrators: cluster.clusterAdministrators,
      clusterClients: cluster.clusterClients,
      clusterSecurityGuard: cluster.clusterSecurityGuard,
    );
  }

  // Método para convertir el modelo en una entidad.
  ClusterEntity toEntity() {
    return ClusterEntity(
      clusterUid: clusterUid,
      clusterLegalId: clusterLegalId,
      clusterName: clusterName,
      clusterDescription: clusterDescription,
      clusterType: clusterType,
      clusterAddress: clusterAddress,
      clusterCoordinates: clusterCoordinates,
      clusterAdministrators: clusterAdministrators,
      clusterClients: clusterClients,
      clusterSecurityGuard: clusterSecurityGuard,
    );
  }
}