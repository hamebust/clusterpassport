import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ClusterEntity: Representa un Cluster (Físico o Jurídico).
/// ClusterEntity: Represents a Cluster (Physical or Legal).
class ClusterEntity extends Equatable {
  /// Identificador único del Cluster.
  /// Unique identifier of the Cluster.
  final String uid;

  /// Identificador legal del Cluster.
  /// Legal identifier of the Cluster.
  final String legalId;

  /// Nombre del Cluster.
  /// Name of the Cluster.
  final String name;

  /// Descripción del Cluster.
  /// Description of the Cluster.
  final String description;

  /// Tipo de Cluster: Físico o Jurídico.
  /// Type of Cluster: Physical or Legal.
  final String type;

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
    this.legalId = '',
    required this.name,
    this.description = '',
    required this.type,
    required this.address,
    required this.coordinates,
  });

  /// Método de fábrica para crear un Cluster Físico.
  /// Factory method to create a Physical Cluster.
  factory ClusterEntity.createPhysicalCluster({
    required String uid,
    required String legalId,
    required String name,
    required String description,
    required Address address,
    required LatLng coordinates,
  }) {
    return ClusterEntity(
      uid: uid,
      legalId: legalId,
      name: name,
      description: description,
      type: 'Physical',
      address: address,
      coordinates: coordinates,
    );
  }

  /// Método de fábrica para crear un Cluster Jurídico.
  /// Factory method to create a Legal Cluster.
  factory ClusterEntity.createLegalCluster({
    required String uid,
    required String legalId,
    required String name,
    required String description,
    required Address address,
    required LatLng coordinates,
  }) {
    return ClusterEntity(
      uid: uid,
      legalId: legalId,
      name: name,
      description: description,
      type: 'Legal',
      address: address,
      coordinates: coordinates,
    );
  }

  /// Método para actualizar la información del Cluster.
  /// Method to update Cluster information.
  ///
  /// Retorna una nueva instancia de `ClusterEntity` con los valores actualizados.
  /// Returns a new `ClusterEntity` instance with updated values.
  ClusterEntity update({
    String? legalId,
    String? name,
    String? description,
    Address? address,
    LatLng? coordinates,
  }) {
    return ClusterEntity(
      uid: this.uid, // El UID permanece igual.
      legalId: legalId ?? this.legalId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: this.type, // El tipo permanece igual (Físico o Jurídico).
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  /// Método para borrar un Cluster.
  /// Method to delete a Cluster.
  ///
  /// En este contexto, eliminar significa devolver un valor `null` o
  /// realizar una lógica de eliminación según el repositorio.
  /// In this context, deleting means returning a `null` value or
  /// performing a deletion logic in the repository.
  static ClusterEntity? delete(ClusterEntity cluster) {
    // Aquí puedes realizar cualquier lógica adicional si es necesario,
    // como registrar la eliminación o notificar a otros servicios.
    // Here you can perform any additional logic if needed,
    // like logging the deletion or notifying other services.
    return null; // Devuelve null para simular la eliminación.
  }

  @override
  List<Object?> get props => [uid, legalId, name, description, type, address, coordinates];
}

/// Address: Representa la dirección de un Cluster.
/// Address: Represents the address of a Cluster.
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
