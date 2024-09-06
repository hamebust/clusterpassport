import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

/// ClusterRepository: Repositorio abstracto que define las operaciones CRUD para los Clusters.
/// ClusterRepository: Abstract repository that defines CRUD operations for Clusters.
abstract class ClusterRepository {
  
  /// Obtiene un Cluster por su identificador único.
  /// Fetches a Cluster by its unique identifier.
  ///
  /// [clusterId] es el identificador del Cluster.
  /// [clusterId] is the identifier of the Cluster.
  ///
  /// Devuelve un objeto `ClusterEntity` si se encuentra, o `null` si no existe.
  /// Returns a `ClusterEntity` object if found, or `null` if not.
  Future<ClusterEntity?> getClusterById(String clusterId);

  /// Obtiene todos los Clusters disponibles.
  /// Fetches all available Clusters.
  ///
  /// Devuelve una lista de objetos `ClusterEntity`.
  /// Returns a list of `ClusterEntity` objects.
  Future<List<ClusterEntity>> getAllClusters();

  /// Crea un nuevo Cluster.
  /// Creates a new Cluster.
  ///
  /// [cluster] es el objeto `ClusterEntity` que representa el Cluster a crear.
  /// [cluster] is the `ClusterEntity` object representing the Cluster to create.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> createCluster(ClusterEntity cluster);

  /// Actualiza la información de un Cluster existente.
  /// Updates the information of an existing Cluster.
  ///
  /// [cluster] es el objeto `ClusterEntity` que contiene los datos actualizados del Cluster.
  /// [cluster] is the `ClusterEntity` object containing the updated Cluster data.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> updateCluster(ClusterEntity cluster);

  /// Elimina un Cluster existente por su identificador.
  /// Deletes an existing Cluster by its identifier.
  ///
  /// [clusterId] es el identificador del Cluster a eliminar.
  /// [clusterId] is the identifier of the Cluster to delete.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> deleteCluster(String clusterId);

  /// Actualiza parcialmente un Cluster.
  /// Partially updates a Cluster.
  ///
  /// [clusterId] es el identificador del Cluster a actualizar.
  /// [clusterId] is the identifier of the Cluster to update.
  ///
  /// [updatedFields] contiene los campos que se van a actualizar.
  /// [updatedFields] contains the fields to be updated.
  ///
  /// Este método no devuelve ningún valor.
  /// This method returns no value.
  Future<void> partialUpdateCluster(String clusterId, Map<String, dynamic> updatedFields);

  /// Obtiene un Stream de un Cluster por su identificador único.
  /// Fetches a Stream of a Cluster by its unique identifier.
  ///
  /// [clusterId] es el identificador del Cluster.
  /// [clusterId] is the identifier of the Cluster.
  ///
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId);
}
