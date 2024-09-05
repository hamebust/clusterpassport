// SectorRepository: Repositorio abstracto que define las operaciones CRUD para los Sectores.
// SectorRepository: Abstract repository that defines CRUD operations for Sectors.

import 'package:cluster_passport/features/clusters/b_sector/domain/entities/sector_entity.dart';

abstract class SectorRepository {

  /// Obtiene un Sector por su identificador único.
  /// Fetches a Sector by its unique identifier.
  ///
  /// [sectorId] es el identificador del Sector.
  /// [sectorId] is the identifier of the Sector.
  ///
  /// Devuelve un objeto `SectorEntity` si se encuentra, o `null` si no existe.
  /// Returns a `SectorEntity` object if found, or `null` if not.
  Future<SectorEntity?> getSectorById(String sectorId);

  /// Obtiene todos los Sectores dentro de un Cluster.
  /// Fetches all Sectors within a Cluster.
  ///
  /// [clusterId] es el identificador del Cluster.
  /// [clusterId] is the identifier of the Cluster.
  ///
  /// Devuelve una lista de objetos `SectorEntity`.
  /// Returns a list of `SectorEntity` objects.
  Future<List<SectorEntity>> getSectorsByClusterId(String clusterId);

  /// Crea un nuevo Sector.
  /// Creates a new Sector.
  ///
  /// [sector] es el objeto `SectorEntity` que representa el Sector a crear.
  /// [sector] is the `SectorEntity` object representing the Sector to create.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> createSector(SectorEntity sector);

  /// Actualiza la información de un Sector existente.
  /// Updates the information of an existing Sector.
  ///
  /// [sector] es el objeto `SectorEntity` que contiene los datos actualizados del Sector.
  /// [sector] is the `SectorEntity` object containing the updated Sector data.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> updateSector(SectorEntity sector);

  /// Elimina un Sector existente por su identificador.
  /// Deletes an existing Sector by its identifier.
  ///
  /// [sectorId] es el identificador del Sector a eliminar.
  /// [sectorId] is the identifier of the Sector to delete.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> deleteSector(String sectorId);

  /// Obtiene un Stream de un Sector por su identificador único.
  /// Fetches a Stream of a Sector by its unique identifier.
  ///
  /// [sectorId] es el identificador del Sector.
  /// [sectorId] is the identifier of the Sector.
  ///
  Stream<SectorEntity?> getSectorByIdStream(String sectorId);
}
