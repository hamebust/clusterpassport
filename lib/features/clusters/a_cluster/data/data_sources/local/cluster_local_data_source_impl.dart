import 'package:cluster_passport/features/clusters/a_cluster/data/data_sources/local/cluster_local_data_source.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';

class ClusterLocalDataSourceImpl implements ClusterLocalDataSource {
  static const String _dbName = 'clusterApp.db';
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
            clusterUid TEXT PRIMARY KEY,
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
      'clusterUid': cluster.clusterUid,
      'legalId': cluster.legalId,
      'name': cluster.clusterName,
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
      clusterUid: map['clusterUid'],
      legalId: map['legalId'] ?? '',
      clusterName: map['name'],
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

  @override
  Future<void> createClusterLocal(ClusterEntity cluster) async {
    await _initializeDatabase();
    await _database!.insert(
      _tableName,
      _toMap(cluster),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<ClusterEntity?> getClusterByIdLocal(String clusterUid) async {
    await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(
      _tableName,
      where: 'clusterUid = ?',
      whereArgs: [clusterUid],
    );

    if (maps.isNotEmpty) {
      return _fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<List<ClusterEntity>> getAllClustersLocal() async {
    await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(_tableName);

    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }

  @override
  Future<void> updateClusterLocal(ClusterEntity cluster) async {
    await _initializeDatabase();
    await _database!.update(
      _tableName,
      _toMap(cluster),
      where: 'clusterUid = ?',
      whereArgs: [cluster.clusterUid],
    );
  }

  @override
  Future<void> deleteClusterLocal(String clusterUid) async {
    await _initializeDatabase();
    await _database!.delete(
      _tableName,
      where: 'clusterUid = ?',
      whereArgs: [clusterUid],
    );
  }

  @override
  Future<void> partialUpdateClusterLocal(String clusterUid, Map<String, dynamic> updatedFields) async {
    await _initializeDatabase();
    await _database!.update(
      _tableName,
      updatedFields,
      where: 'clusterUid = ?',
      whereArgs: [clusterUid],
    );
  }

  @override
  Stream<ClusterEntity?> getClusterByIdStreamLocal(String clusterUid) async* {
    while (true) {
      final cluster = await getClusterByIdLocal(clusterUid);
      yield cluster;
      await Future.delayed(const Duration(seconds: 2)); // Retraso para simular polling
    }
  }
}
