import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ClusterEntity: Representa un Cluster (Físico o Jurídico).
class ClusterEntity extends Equatable {
  /// Identificador único del Cluster.
  final String clusterUid;

  /// Identificador legal del Cluster.
  final String legalId;

  /// Nombre del Cluster.
  final String clusterName; // Renombrado de clustername a clusterName.

  /// Descripción del Cluster.
  final String description;

  /// Tipo de Cluster: Físico o Jurídico.
  final String clusterType;

  /// Tipo de Cluster: Físico o Jurídico.

  /// Dirección del Cluster.
  final Address address;

  /// Coordenadas geográficas del Cluster.
  final LatLng coordinates;

  /// Lista de administradores del Cluster.
  final List<String> administrators; // Nueva variable.

  /// Lista de usuarios del Cluster.
  final List<String> clients; // Nueva variable.

  /// Lista de vigilantes del Cluster.
  final List<String> securityGuard; // Nueva variable.

  /// Constructor principal para ClusterEntity.
  const ClusterEntity({
    required this.clusterUid,
    this.legalId = '',
    required this.clusterName, // Renombrado.
    this.description = '',
    required this.clusterType,
    this.address = const Address(
      streetTypeAndName: '',
      buildingNumber: '',
      neighborhood: '',
      postalCode: '',
      city: '',
      state: '',
      country: '',
    ),
    this.coordinates = const LatLng(10.190175951856812, -64.68849907415074),
    this.administrators = const [], // Inicializa lista vacía.
    this.clients = const [], // Inicializa lista vacía.
    this.securityGuard = const [], // Inicializa lista vacía.
  });

  /// Método de fábrica para crear un Cluster Físico.
  factory ClusterEntity.createPhysicalCluster({
    required String clusterUid,
    required String legalId,
    required String clusterName, // Renombrado.
    required String description,
    required Address address,
    required LatLng coordinates,
    List<String> administrators = const [],
    List<String> clients = const [],
    List<String> securityGuard = const [],
  }) {
    return ClusterEntity(
      clusterUid: clusterUid,
      legalId: legalId,
      clusterName: clusterName,
      description: description,
      clusterType: 'Physical',
      address: address,
      coordinates: coordinates,
      administrators: administrators,
      clients: clients,
      securityGuard: securityGuard,
    );
  }

  /// Método de fábrica para crear un Cluster Jurídico.
  factory ClusterEntity.createLegalCluster({
    required String clusterUid,
    required String legalId,
    required String clusterName, // Renombrado.
    required String description,
    required Address address,
    required LatLng coordinates,
    List<String> administrators = const [],
    List<String> clients = const [],
    List<String> securityGuard = const [],
  }) {
    return ClusterEntity(
      clusterUid: clusterUid,
      legalId: legalId,
      clusterName: clusterName,
      description: description,
      clusterType: 'Legal',
      address: address,
      coordinates: coordinates,
      administrators: administrators,
      clients: clients,
      securityGuard: securityGuard,
    );
  }

  /// Método para actualizar la información del Cluster.
  ClusterEntity update({
    String? legalId,
    String? clusterName, // Renombrado.
    String? description,
    Address? address,
    LatLng? coordinates,
    List<String>? administrators,
    List<String>? clients,
    List<String>? securityGuard,
  }) {
    return ClusterEntity(
      clusterUid: clusterUid,
      legalId: legalId ?? this.legalId,
      clusterName: clusterName ?? this.clusterName, // Renombrado.
      description: description ?? this.description,
      clusterType: clusterType,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
      administrators: administrators ?? this.administrators,
      clients: clients ?? this.clients,
      securityGuard: securityGuard ?? this.securityGuard,
    );
  }

  /// Método para borrar un Cluster.
  static ClusterEntity? delete(ClusterEntity cluster) {
    return null;
  }

  @override
  List<Object?> get props => [
        clusterUid,
        legalId,
        clusterName, // Renombrado.
        description,
        clusterType,
        address,
        coordinates,
        administrators, // Nueva variable.
        clients, // Nueva variable.
        securityGuard, // Nueva variable.
      ];
}

/// Address: Representa la dirección de un Cluster.
class Address extends Equatable {
  final String streetTypeAndName;
  final String buildingNumber;
  final String apartmentOrFloor;
  final String neighborhood;
  final String postalCode;
  final String city;
  final String state;
  final String country;

  const Address({
    required this.streetTypeAndName,
    required this.buildingNumber,
    this.apartmentOrFloor = '',
    required this.neighborhood,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
  });

  @override
  List<Object?> get props => [
        streetTypeAndName,
        buildingNumber,
        apartmentOrFloor,
        neighborhood,
        postalCode,
        city,
        state,
        country,
      ];
}
