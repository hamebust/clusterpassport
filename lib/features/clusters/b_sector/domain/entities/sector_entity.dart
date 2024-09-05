import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// SectorEntity: Representa un Sector dentro de un F-Cluster.
/// SectorEntity: Represents a Sector within an F-Cluster.
class SectorEntity extends Equatable {
  final String id;
  final String name;

  /// Identificador del Cluster al que pertenece el sector.
  /// Identifier of the Cluster the sector belongs to.
  final String clusterId;

  /// Lista de unidades dentro del sector.
  /// List of units within the sector.
  final List<UnitEntity> units;

  /// Coordenadas geográficas del sector.
  /// Geographical coordinates of the sector.
  final LatLng location;

  /// Ubicación del sector.
  /// Ubication of the sector.
  final String ubication;

  /// Constructor principal de SectorEntity.
  /// Main constructor of SectorEntity.
  const SectorEntity({
    required this.id,
    required this.name,
    required this.clusterId,
    required this.units,
    required this.location,
    required this.ubication,
  });

  /// Método para agregar una nueva unidad al sector.
  /// Method to add a new unit to the sector.
  void addUnit(UnitEntity unit) {
    units.add(unit);
  }

  /// Método para modificar una unidad existente dentro del sector.
  /// Method to modify an existing unit within the sector.
  void updateUnit(String unitId, String newName) {
    final index = units.indexWhere((unit) => unit.id == unitId);
    if (index != -1) {
      units[index] = UnitEntity(id: unitId, name: newName);
    }
  }

  /// Método para eliminar una unidad del sector.
  /// Method to remove a unit from the sector.
  void removeUnit(String unitId) {
    units.removeWhere((unit) => unit.id == unitId);
  }

  @override
  List<Object?> get props => [id, name, clusterId, units, location, ubication];
}

/// UnitEntity: Representa una unidad dentro de un sector.
/// UnitEntity: Represents a unit within a sector.
class UnitEntity extends Equatable {
  final String id;
  final String name;

  /// Constructor principal de UnitEntity.
  /// Main constructor of UnitEntity.
  const UnitEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
