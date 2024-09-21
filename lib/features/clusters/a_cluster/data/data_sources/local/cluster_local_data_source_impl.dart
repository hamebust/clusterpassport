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
    if (_database != null)
      return; // Si la base de datos ya está inicializada, no hacer nada.
    _database = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            clusterUid TEXT PRIMARY KEY,
            clusterLegalId TEXT,
            name TEXT,
            clusterDescription TEXT,
            clusterType TEXT,
            clusterAddressStreetTypeAndName TEXT,
            clusterAddressBuildingNumber TEXT,
            clusterAddressApartmentOrFloor TEXT,
            clusterAddressNeighborhood TEXT,
            clusterAddressPostalCode TEXT,
            clusterAddressCity TEXT,
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
      'clusterLegalId': cluster.clusterLegalId,
      'name': cluster.clusterName,
      'clusterDescription': cluster.clusterDescription,
      'clusterType': cluster.clusterType,
      'clusterAddressStreetTypeAndName':
          cluster.clusterAddress.clusterAddressStreetTypeAndName,
      'clusterAddressBuildingNumber':
          cluster.clusterAddress.clusterAddressBuildingNumber,
      'clusterAddressApartmentOrFloor':
          cluster.clusterAddress.clusterAddressApartmentOrFloor,
      'clusterAddressNeighborhood':
          cluster.clusterAddress.clusterAddressNeighborhood,
      'clusterAddressPostalCode':
          cluster.clusterAddress.clusterAddressPostalCode,
      'clusterAddressCity': cluster.clusterAddress.clusterAddressCity,
      'state': cluster.clusterAddress.state,
      'country': cluster.clusterAddress.country,
      'latitude': cluster.clusterCoordinates.latitude,
      'longitude': cluster.clusterCoordinates.longitude,
    };
  }

  /// Convierte un mapa de SQLite en un ClusterEntity.
  /// Converts a SQLite map into a ClusterEntity.
  ClusterEntity _fromMap(Map<String, dynamic> map) {
    return ClusterEntity(
      clusterUid: map['clusterUid'],
      clusterLegalId: map['clusterLegalId'] ?? '',
      clusterName: map['name'],
      clusterDescription: map['clusterDescription'] ?? '',
      clusterType: map['clusterType'],
      clusterAddress: ClusterAddress(
        clusterAddressStreetTypeAndName: map['clusterAddressStreetTypeAndName'],
        clusterAddressBuildingNumber: map['clusterAddressBuildingNumber'],
        clusterAddressApartmentOrFloor:
            map['clusterAddressApartmentOrFloor'] ?? '',
        clusterAddressNeighborhood: map['clusterAddressNeighborhood'],
        clusterAddressPostalCode: map['clusterAddressPostalCode'],
        clusterAddressCity: map['clusterAddressCity'],
        state: map['state'],
        country: map['country'],
      ),
      clusterCoordinates: LatLng(map['latitude'], map['longitude']),
    );
  }

  @override
  Future<void> clusteLocalDataSourceCreate(ClusterEntity cluster) async {
    await _initializeDatabase();
    await _database!.insert(
      _tableName,
      _toMap(cluster),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<ClusterEntity?> clusteLocalDataSourceGetByIdLocal(
      String clusterUid) async {
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
  Future<List<ClusterEntity>> clusteLocalDataSourceGetAll() async {
    await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query(_tableName);

    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }

  @override
  Future<void> clusteLocalDataSourceUpdate(ClusterEntity cluster) async {
    await _initializeDatabase();
    await _database!.update(
      _tableName,
      _toMap(cluster),
      where: 'clusterUid = ?',
      whereArgs: [cluster.clusterUid],
    );
  }

  @override
  Future<void> clusteLocalDataSourceDelete(String clusterUid) async {
    await _initializeDatabase();
    await _database!.delete(
      _tableName,
      where: 'clusterUid = ?',
      whereArgs: [clusterUid],
    );
  }

  @override
  Future<void> partialUpdateClusterLocal(
      String clusterUid, Map<String, dynamic> updatedFields) async {
    await _initializeDatabase();
    await _database!.update(
      _tableName,
      updatedFields,
      where: 'clusterUid = ?',
      whereArgs: [clusterUid],
    );
  }

  @override
  Stream<ClusterEntity?> clusteLocalDataSourceGetByIdStreamLocal(
      String clusterUid) async* {
    while (true) {
      final cluster = await clusteLocalDataSourceGetByIdLocal(clusterUid);
      yield cluster;
      await Future.delayed(
          const Duration(seconds: 2)); // Retraso para simular polling
    }
  }
}
