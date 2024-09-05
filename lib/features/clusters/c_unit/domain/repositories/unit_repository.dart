// UnitRepository: Repositorio abstracto que define las operaciones CRUD para las Unidades.
// UnitRepository: Abstract repository that defines CRUD operations for Units.

import 'package:cluster_passport/features/clusters/b_sector/domain/entities/sector_entity.dart';

abstract class UnitRepository {
  /// Obtiene una Unidad por su identificador único.
  /// Fetches a Unit by its unique identifier.
  ///
  /// [unitId] es el identificador de la Unidad.
  /// [unitId] is the identifier of the Unit.
  ///
  /// Devuelve un objeto `UnitEntity` si se encuentra, o `null` si no existe.
  /// Returns a `UnitEntity` object if found, or `null` if not.
  Future<UnitEntity?> getUnitById(String unitId);

  /// Obtiene todas las Unidades dentro de un Sector.
  /// Fetches all Units within a Sector.
  ///
  /// [sectorId] es el identificador del Sector.
  /// [sectorId] is the identifier of the Sector.
  ///
  /// Devuelve una lista de objetos `UnitEntity`.
  /// Returns a list of `UnitEntity` objects.
  Future<List<UnitEntity>> getUnitsBySectorId(String sectorId);

  /// Crea una nueva Unidad.
  /// Creates a new Unit.
  ///
  /// [unit] es el objeto `UnitEntity` que representa la Unidad a crear.
  /// [unit] is the `UnitEntity` object representing the Unit to create.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> createUnit(UnitEntity unit);

  /// Actualiza la información de una Unidad existente.
  /// Updates the information of an existing Unit.
  ///
  /// [unit] es el objeto `UnitEntity` que contiene los datos actualizados de la Unidad.
  /// [unit] is the `UnitEntity` object containing the updated Unit data.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> updateUnit(UnitEntity unit);

  /// Elimina una Unidad existente por su identificador.
  /// Deletes an existing Unit by its identifier.
  ///
  /// [unitId] es el identificador de la Unidad a eliminar.
  /// [unitId] is the identifier of the Unit to delete.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> deleteUnit(String unitId);

  /// Obtiene un Stream de una Unidad por su identificador único.
  /// Fetches a Stream of a Unit by its unique identifier.
  ///
  /// [unitId] es el identificador de la Unidad.
  /// [unitId] is the identifier of the Unit.
  ///
  Stream<UnitEntity?> getUnitByIdStream(String unitId);
}
