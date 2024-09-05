import 'package:equatable/equatable.dart';

/// UnitEntity: Representa una Unidad dentro de un Sector o Área.
/// UnitEntity: Represents a Unit within a Sector or Area.
class UnitEntity extends Equatable {
  /// Identificador único de la unidad.
  /// Unique identifier of the unit.
  final String id;

  /// Nombre de la unidad.
  /// Name of the unit.
  final String name;

  /// Identificador del sector o área al que pertenece la unidad.
  /// Identifier of the sector or area to which the unit belongs.
  final String sectorId;

  /// Lista de identificadores de J-Clusters asociados a esta unidad.
  /// List of identifiers for J-Clusters associated with this unit.
  final List<String> jClusterIds;

  /// Lista de identificadores de usuarios asociados a esta unidad.
  /// List of user IDs associated with this unit.
  final List<String> userIds;

  /// Detalles de la ubicación de la unidad (dirección).
  /// Location details of the unit (address).
  final String ubication;

  /// Constructor principal de UnitEntity.
  /// Main constructor for UnitEntity.
  const UnitEntity({
    required this.id,
    required this.name,
    required this.sectorId,
    required this.jClusterIds,
    required this.userIds,
    required this.ubication,
  });

  /// Método para agregar un J-Cluster a la unidad.
  /// Method to add a J-Cluster to the unit.
  void addJCluster(String jClusterId) {
    if (!jClusterIds.contains(jClusterId)) {
      jClusterIds.add(jClusterId);
    }
  }

  /// Método para eliminar un J-Cluster de la unidad.
  /// Method to remove a J-Cluster from the unit.
  void removeJCluster(String jClusterId) {
    jClusterIds.remove(jClusterId);
  }

  /// Método para agregar un usuario a la unidad.
  /// Method to add a user to the unit.
  void addUser(String userId) {
    if (!userIds.contains(userId)) {
      userIds.add(userId);
    }
  }

  /// Método para eliminar un usuario de la unidad.
  /// Method to remove a user from the unit.
  void removeUser(String userId) {
    userIds.remove(userId);
  }

  @override
  List<Object?> get props => [id, name, sectorId, jClusterIds, userIds, ubication];
}
