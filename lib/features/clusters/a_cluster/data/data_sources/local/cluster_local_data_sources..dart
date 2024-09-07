// ignore: file_names

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

class ClusterLocalDataSource {
  static const String _dbName = 'clusters.db';
  static const String _tableName = 'clusters';
  static const int _dbVersion = 1;
  static Database? _database;

  /// Inicializa la base de datos y crea la tabla de clusters si no existe.
  /// Initializes the database and creates the clusters table if it doesn't exist.
  Future<void> _initializeDatabase() async {
    if (_database != null) return; // Si la base de datos ya está inicializada, no hacer nada.
    _database = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            uid TEXT PRIMARY KEY,
            legalId TEXT,
            name TEXT,
            description TEXT,
            type TEXT,
            streetTypeAndName TEXT,
            buildingNumber TEXT,
            apartmentOrFloor TEXT,
            neighborhood TEXT,
            postalCode TEXT,
            city TEXT,
            state TEXT,
            country TEXT,
            latitude REAL,
            longitude REAL
          )
        ''');
      },
    );
  }

  /// Convierte un ClusterEntity en un mapa para almacenamiento en SQLite.
  /// Converts a ClusterEntity into a map for SQLite storage.
  Map<String, dynamic> _toMap(ClusterEntity cluster) {
    return {
      'uid': cluster.uid,
      'legalId': cluster.legalId,
      'name': cluster.clustername,
      'description': cluster.description,
      'type': cluster.type,
      'streetTypeAndName': cluster.address.streetTypeAndName,
      'buildingNumber': cluster.address.buildingNumber,
      'apartmentOrFloor': cluster.address.apartmentOrFloor,
      'neighborhood': cluster.address.neighborhood,
      'postalCode': cluster.address.postalCode,
      'city': cluster.address.city,
      'state': cluster.address.state,
      'country': cluster.address.country,
      'latitude': cluster.coordinates.latitude,
      'longitude': cluster.coordinates.longitude,
    };
  }

  /// Convierte un mapa de SQLite en un ClusterEntity.
  /// Converts a SQLite map into a ClusterEntity.
  ClusterEntity _fromMap(Map<String, dynamic> map) {
    return ClusterEntity(
      uid: map['uid'],
      legalId: map['legalId'] ?? '',
      clustername: map['clustername'],
      description: map['description'] ?? '',
      type: map['type'],
      address: Address(
        streetTypeAndName: map['streetTypeAndName'],
        buildingNumber: map['buildingNumber'],
        apartmentOrFloor: map['apartmentOrFloor'] ?? '',
        neighborhood: map['neighborhood'],
        postalCode: map['postalCode'],
        city: map['city'],
        state: map['state'],
        country: map['country'],
      ),
      coordinates: LatLng(map['latitude'], map['longitude']),
    );
  }

  /// Crea un nuevo Cluster en la base de datos.
  /// Creates a new Cluster in the database.
  Future<void> createCluster(ClusterEntity cluster) async {
    await _initializeDatabase();
    await _database!.insert(
      _tableName,
      _toMap(cluster),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtiene un Cluster por su identificador único.
  /// Retrieves a Cluster by its unique identifier.
  Future<ClusterEntity?> getClusterById(String clusterId) async {
    await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(
      _tableName,
      where: 'uid = ?',
      whereArgs: [clusterId],
    );

    if (maps.isNotEmpty) {
      return _fromMap(maps.first);
    }
    return null;
  }

  /// Obtiene todos los Clusters almacenados en la base de datos.
  /// Retrieves all Clusters stored in the database.
  Future<List<ClusterEntity>> getAllClusters() async {
    await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(_tableName);

    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }

  /// Actualiza un Cluster existente en la base de datos.
  /// Updates an existing Cluster in the database.
  Future<void> updateCluster(ClusterEntity cluster) async {
    await _initializeDatabase();
    await _database!.update(
      _tableName,
      _toMap(cluster),
      where: 'uid = ?',
      whereArgs: [cluster.uid],
    );
  }

  /// Elimina un Cluster de la base de datos por su identificador único.
  /// Deletes a Cluster from the database by its unique identifier.
  Future<void> deleteCluster(String clusterId) async {
    await _initializeDatabase();
    await _database!.delete(
      _tableName,
      where: 'uid = ?',
      whereArgs: [clusterId],
    );
  }

  /// Actualiza parcialmente un Cluster en la base de datos.
  /// Partially updates a Cluster in the database.
  Future<void> partialUpdateCluster(String clusterId, Map<String, dynamic> updatedFields) async {
    await _initializeDatabase();
    await _database!.update(
      _tableName,
      updatedFields,
      where: 'uid = ?',
      whereArgs: [clusterId],
    );
  }

  /// Obtiene un Stream de un Cluster por su identificador único.
  /// Retrieves a Stream of a Cluster by its unique identifier.
  Stream<ClusterEntity?> getClusterByIdStream(String clusterId) async* {
    while (true) {
      final cluster = await getClusterById(clusterId);
      yield cluster;
      await Future.delayed(const Duration(seconds: 2)); // Retraso para simular polling
    }
  }
}
