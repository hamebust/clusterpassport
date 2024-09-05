import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ClusterEntity: Representa un Cluster en la aplicación, que puede ser un F-Cluster o J-Cluster.
/// ClusterEntity: Represents a Cluster in the application, which can be a Physical or Legal Cluster.
class ClusterEntity extends Equatable {
  /// Identificador único del Cluster.
  /// Unique identifier of the Cluster.
  final String uid;

  /// Nombre del Cluster.
  /// Name of the Cluster.
  final String name;

  /// Tipo de Cluster: Físico o Jurídico.
  /// Type of Cluster: Physical or Legal.
  final String type;

  /// Lista de Sectores o Áreas dentro del Cluster.
  /// List of Sectors or Areas within the Cluster.
  final List<SectorEntity> sectors;

  /// Dirección del Cluster.
  /// Address of the Cluster.
  final Address address;

  /// Coordenadas geográficas del Cluster.
  /// Geographical coordinates of the Cluster.
  final LatLng coordinates;

  /// Constructor principal para ClusterEntity.
  /// Main constructor for ClusterEntity.
  const ClusterEntity({
    required this.uid,
    required this.name,
    required this.type,
    required this.sectors,
    required this.address,
    required this.coordinates,
  });

  /// Método de fábrica para crear un Cluster Físico.
  /// Factory method to create a Physical Cluster.
  factory ClusterEntity.createPhysicalCluster({
    required String uid,
    required String name,
    required List<SectorEntity> sectors,
    required Address address,
    required LatLng coordinates,
  }) {
    return ClusterEntity(
      uid: uid,
      name: name,
      type: 'Physical',
      sectors: sectors,
      address: address,
      coordinates: coordinates,
    );
  }

  /// Método de fábrica para crear un Cluster Jurídico.
  /// Factory method to create a Legal Cluster.
  factory ClusterEntity.createLegalCluster({
    required String uid,
    required String name,
    required List<SectorEntity> sectors,
    required Address address,
    required LatLng coordinates,
  }) {
    return ClusterEntity(
      uid: uid,
      name: name,
      type: 'Legal',
      sectors: sectors,
      address: address,
      coordinates: coordinates,
    );
  }

  /// Agrega un nuevo sector al Cluster.
  /// Adds a new sector to the Cluster.
  void addSector(SectorEntity sector) {
    sectors.add(sector);
  }

  /// Modifica un sector existente en el Cluster.
  /// Modifies an existing sector in the Cluster.
  void updateSector(String sectorId, String newName) {
    final index = sectors.indexWhere((sector) => sector.uid == sectorId);
    if (index != -1) {
      sectors[index] = sectors[index].copyWith(name: newName);
    }
  }

  /// Elimina un sector del Cluster.
  /// Removes a sector from the Cluster.
  void removeSector(String sectorId) {
    sectors.removeWhere((sector) => sector.uid == sectorId);
  }

  @override
  List<Object> get props => [uid, name, type, sectors, address, coordinates];
}

/// SectorEntity: Representa un Sector o Área dentro de un Cluster.
/// SectorEntity: Represents a Sector or Area within a Cluster.
class SectorEntity extends Equatable {
  final String uid;
  final String name;

  const SectorEntity({
    required this.uid,
    required this.name,
  });

  /// Método para copiar una entidad de Sector con nuevos valores.
  /// Method to copy a Sector entity with new values.
  SectorEntity copyWith({
    String? uid,
    String? name,
  }) {
    return SectorEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [uid, name];
}

/// Address: Representa la dirección detallada de un Cluster.
/// Address: Represents the detailed address of a Cluster.
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
