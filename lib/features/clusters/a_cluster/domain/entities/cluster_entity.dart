import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ClusterEntity: Representa un Cluster (Físico o Jurídico).
class ClusterEntity extends Equatable {
  final String clusterUid;
  final String clusterLegalId;
  final String clusterName;
  final String clusterDescription;
  final String clusterType;
  final ClusterAddress clusterAddress;
  final LatLng clusterCoordinates;
  final List<String> clusterAdministrators;
  final List<String> clusterClients;
  final List<String> clusterSecurityGuard;

  /// Constructor principal para ClusterEntity.
  const ClusterEntity({
    required this.clusterUid,
    this.clusterLegalId = '',
    required this.clusterName, // Renombrado.
    this.clusterDescription = '',
    required this.clusterType,
    this.clusterAddress = const ClusterAddress(
      clusterAddressStreetTypeAndName: '',
      clusterAddressBuildingNumber: '',
      clusterAddressNeighborhood: '',
      clusterAddressPostalCode: '',
      clusterAddressCity: '',
      state: '',
      country: '',
    ),
    this.clusterCoordinates =
        const LatLng(10.190175951856812, -64.68849907415074),
    this.clusterAdministrators = const [], // Inicializa lista vacía.
    this.clusterClients = const [], // Inicializa lista vacía.
    this.clusterSecurityGuard = const [], // Inicializa lista vacía.
  });

  /// Método de fábrica para crear un Cluster Físico.
  factory ClusterEntity.clusterEntityCreatePhysical({
    required String clusterUid,
    required String clusterLegalId,
    required String clusterName, // Renombrado.
    required String clusterDescription,
    required ClusterAddress clusterAddress,
    required LatLng clusterCoordinates,
    List<String> clusterAdministrators = const [],
    List<String> clusterClients = const [],
    List<String> clusterSecurityGuard = const [],
  }) {
    return ClusterEntity(
      clusterUid: clusterUid,
      clusterLegalId: clusterLegalId,
      clusterName: clusterName,
      clusterDescription: clusterDescription,
      clusterType: 'Physical',
      clusterAddress: clusterAddress,
      clusterCoordinates: clusterCoordinates,
      clusterAdministrators: clusterAdministrators,
      clusterClients: clusterClients,
      clusterSecurityGuard: clusterSecurityGuard,
    );
  }

  /// Método de fábrica para crear un Cluster Jurídico.
  factory ClusterEntity.clusterEntityCreateLegal({
    required String clusterUid,
    required String clusterLegalId,
    required String clusterName, // Renombrado.
    required String clusterDescription,
    required ClusterAddress clusterAddress,
    required LatLng clusterCoordinates,
    List<String> clusterAdministrators = const [],
    List<String> clusterClients = const [],
    List<String> clusterSecurityGuard = const [],
  }) {
    return ClusterEntity(
      clusterUid: clusterUid,
      clusterLegalId: clusterLegalId,
      clusterName: clusterName,
      clusterDescription: clusterDescription,
      clusterType: 'Legal',
      clusterAddress: clusterAddress,
      clusterCoordinates: clusterCoordinates,
      clusterAdministrators: clusterAdministrators,
      clusterClients: clusterClients,
      clusterSecurityGuard: clusterSecurityGuard,
    );
  }
 
  /// Método para actualizar la información del Cluster.
  ClusterEntity update({
    String? clusterLegalId,
    String? clusterName, // Renombrado.
    String? clusterDescription,
    ClusterAddress? clusterAddress,
    LatLng? clusterCoordinates,
    List<String>? clusterAdministrators,
    List<String>? clusterClients,
    List<String>? clusterSecurityGuard,
  }) {
    return ClusterEntity(
      clusterUid: clusterUid,
      clusterLegalId: clusterLegalId ?? this.clusterLegalId,
      clusterName: clusterName ?? this.clusterName, // Renombrado.
      clusterDescription: clusterDescription ?? this.clusterDescription,
      clusterType: clusterType,
      clusterAddress: clusterAddress ?? this.clusterAddress,
      clusterCoordinates: clusterCoordinates ?? this.clusterCoordinates,
      clusterAdministrators:
          clusterAdministrators ?? this.clusterAdministrators,
      clusterClients: clusterClients ?? this.clusterClients,
      clusterSecurityGuard: clusterSecurityGuard ?? this.clusterSecurityGuard,
    );
  }

  /// Método para borrar un Cluster.
  static ClusterEntity? delete(ClusterEntity cluster) {
    return null;
  }

  @override
  List<Object?> get props => [
        clusterUid,
        clusterLegalId,
        clusterName, // Renombrado.
        clusterDescription,
        clusterType,
        clusterAddress,
        clusterCoordinates,
        clusterAdministrators, // Nueva variable.
        clusterClients, // Nueva variable.
        clusterSecurityGuard, // Nueva variable.
      ];
}

/// Address: Representa la dirección de un Cluster.
class ClusterAddress extends Equatable {
  final String clusterAddressStreetTypeAndName;
  final String clusterAddressBuildingNumber;
  final String clusterAddressApartmentOrFloor;
  final String clusterAddressNeighborhood;
  final String clusterAddressPostalCode;
  final String clusterAddressCity;
  final String state;
  final String country;

  const ClusterAddress({
    this.clusterAddressStreetTypeAndName = '',
    this.clusterAddressBuildingNumber = '',
    this.clusterAddressApartmentOrFloor = '',
    this.clusterAddressNeighborhood = '',
    this.clusterAddressPostalCode = '',
    this.clusterAddressCity = '',
    this.state = '',
    this.country = '',
  });

  @override
  List<Object?> get props => [
        clusterAddressStreetTypeAndName,
        clusterAddressBuildingNumber,
        clusterAddressApartmentOrFloor,
        clusterAddressNeighborhood,
        clusterAddressPostalCode,
        clusterAddressCity,
        state,
        country,
      ];
}
