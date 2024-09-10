import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusterModel extends ClusterEntity {
  @override
  final String clusterUid;
  @override
  final String legalId;
  @override
  final String clusterName;
  @override
  final String description;
  @override
  final String type;
  @override
  final Address address;
  @override
  final LatLng coordinates;

  // Nuevas variables añadidas.
  @override
  final List<String> administrators;
  @override
  final List<String> clients;
  @override
  final List<String> securityGuard;

  const ClusterModel({
    required this.clusterUid,
    required this.legalId,
    required this.clusterName,
    required this.description,
    required this.type,
    required this.address,
    required this.coordinates,
    this.administrators = const [], // Inicializamos las listas.
    this.clients = const [],
    this.securityGuard = const [],
  }) : super(
          clusterUid: clusterUid,
          legalId: legalId,
          clusterName: clusterName,
          description: description,
          type: type,
          address: address,
          coordinates: coordinates,
          administrators: administrators,
          clients: clients,
          securityGuard: securityGuard,
        );

  // Factory method para crear un ClusterModel desde un snapshot de Firebase.
  factory ClusterModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return ClusterModel(
      clusterUid: snap['clusterUid'],
      legalId: snap['legalId'],
      clusterName: snap['clusterName'],
      description: snap['description'],
      type: snap['type'],
      address: Address(
        streetTypeAndName: snap['streetTypeAndName'],
        buildingNumber: snap['buildingNumber'],
        apartmentOrFloor: snap['apartmentOrFloor'],
        neighborhood: snap['neighborhood'],
        postalCode: snap['postalCode'],
        city: snap['city'],
        state: snap['state'],
        country: snap['country'],
      ),
      coordinates: LatLng(
        snap['latitude'],
        snap['longitude'],
      ),
      administrators: List<String>.from(snap['administrators'] ?? []),
      clients: List<String>.from(snap['clients'] ?? []),
      securityGuard: List<String>.from(snap['securityGuard'] ?? []),
    );
  }

  // Método para convertir el modelo en un mapa para subir a Firebase.
  Map<String, dynamic> toDocument() => {
        "clusterUid": clusterUid,
        "legalId": legalId,
        "clusterName": clusterName,
        "description": description,
        "type": type,
        "streetTypeAndName": address.streetTypeAndName,
        "buildingNumber": address.buildingNumber,
        "apartmentOrFloor": address.apartmentOrFloor,
        "neighborhood": address.neighborhood,
        "postalCode": address.postalCode,
        "city": address.city,
        "state": address.state,
        "country": address.country,
        "latitude": coordinates.latitude,
        "longitude": coordinates.longitude,
        "administrators": administrators,
        "clients": clients,
        "securityGuard": securityGuard,
      };

  // Método de fábrica para crear un ClusterModel desde una entidad existente.
  factory ClusterModel.fromEntity(ClusterEntity cluster) {
    return ClusterModel(
      clusterUid: cluster.clusterUid,
      legalId: cluster.legalId,
      clusterName: cluster.clusterName,
      description: cluster.description,
      type: cluster.type,
      address: cluster.address,
      coordinates: cluster.coordinates,
      administrators: cluster.administrators,
      clients: cluster.clients,
      securityGuard: cluster.securityGuard,
    );
  }

  // Método para convertir el modelo en una entidad.
  ClusterEntity toEntity() {
    return ClusterEntity(
      clusterUid: clusterUid,
      legalId: legalId,
      clusterName: clusterName,
      description: description,
      type: type,
      address: address,
      coordinates: coordinates,
      administrators: administrators,
      clients: clients,
      securityGuard: securityGuard,
    );
  }
}
