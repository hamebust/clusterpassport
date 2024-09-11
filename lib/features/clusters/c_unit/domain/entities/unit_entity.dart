import 'package:equatable/equatable.dart';

/// UnitEntity: Representa una Unidad dentro de un Sector o Área.
/// UnitEntity: Represents a Unit within a Sector or Area.
class UnitEntity extends Equatable {
  /// Identificador único de la Unidad.
  /// Unique identifier of the Unit.
  final String uid;

  /// Nombre de la Unidad.
  /// Name of the Unit.
  final String name;

  /// ID del Sector o Área al que pertenece la Unidad.
  /// ID of the Sector or Area the Unit belongs to.
  final String sectorId;

  /// Lista de IDs de J-Clusters asociados a esta Unidad.
  /// List of IDs of J-Clusters associated with this Unit.
  final List<String> jClusterIds;

  /// Lista de IDs de usuarios asociados a esta Unidad.
  /// List of user IDs associated with this Unit.
  final List<String> userIds;

  /// Ubicación detallada de la Unidad.
  /// Detailed location of the Unit.
  final String location;

  /// Constructor principal para UnitEntity.
  /// Main constructor for UnitEntity.
  const UnitEntity({
    required this.uid,
    required this.name,
    required this.sectorId,
    required this.jClusterIds,
    required this.userIds,
    required this.location,
  });

  /// Método de fábrica para crear una nueva Unidad.
  /// Factory method to create a new Unit.
  factory UnitEntity.create({
    required String uid,
    required String name,
    required String sectorId,
    required String location,
    List<String>? jClusterIds,
    List<String>? userIds,
  }) {
    return UnitEntity(
      uid: uid,
      name: name,
      sectorId: sectorId,
      jClusterIds: jClusterIds ?? [],
      userIds: userIds ?? [],
      location: location,
    );
  }

  /// Modifica la información de la Unidad.
  /// Updates the information of the Unit.
  UnitEntity updateUnit({
    String? newName,
    String? newLocation,
  }) {
    return UnitEntity(
      uid: uid,
      name: newName ?? name,
      sectorId: sectorId,
      jClusterIds: jClusterIds,
      userIds: userIds,
      location: newLocation ?? location,
    );
  }

  /// Agrega uno o varios J-Clusters a la Unidad.
  /// Adds one or more J-Clusters to the Unit.
  UnitEntity addJClusters(List<String> newJClusters) {
    return UnitEntity(
      uid: uid,
      name: name,
      sectorId: sectorId,
      jClusterIds: [...jClusterIds, ...newJClusters],
      userIds: userIds,
      location: location,
    );
  }

  /// Elimina una Unidad.
  /// Deletes the Unit.
  UnitEntity deleteUnit() {
    return UnitEntity(
      uid: uid,
      name: '',
      sectorId: sectorId,
      jClusterIds: const [],
      userIds: const [],
      location: '',
    );
  }

  @override
  List<Object?> get props => [uid, name, sectorId, jClusterIds, userIds, location];
}
