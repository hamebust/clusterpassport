
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusterModel extends ClusterEntity {
  
  @override
  final String uid;
  // ignore: overridden_fields
  @override
  final String legalId;
  // ignore: overridden_fields
  @override
  final String clustername;
  
  @override
  final String description;

  @override
  final String type;
  // ignore: overridden_fields
  @override
  final Address address;
  // ignore: overridden_fields
  @override
  final LatLng coordinates;

  const ClusterModel({
    required this.uid,
    required this.legalId,
    required this.clustername,
    required this.description,
    required this.type,
    required this.address,
    required this.coordinates,
  }) : super(
    uid: uid,
    legalId: legalId,
    clustername: clustername,
    description: description,
    type: type,
    address: address,
    coordinates: coordinates,
  );

  factory ClusterModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return ClusterModel(
      uid: snap['uid'],
      legalId: snap['legalId'],
      clustername: snap['clustername'],
      description: snap['description'],
      type: snap['type'],
      address: Address(
        streetTypeAndName: snap['streetTypeAndName'],
        buildingNumber: snap['buildingNumber'],
        apartmentOrFloor: snap['apartmentOrFloor'],
        neighborhood: snap['neighborhood'],
        postalCode: snap['postalCode'],
        city: snap['city'],
        state: snap['state'],
        country: snap['country'],
      ),
      coordinates: LatLng(
        snap['latitude'],
        snap['longitude'],
      ),
    );
  }

  Map<String, dynamic> toDocument() => {
    "uid": uid,
    "legalId": legalId,
    "clustername": clustername,
    "description": description,
    "type": type,
    "streetTypeAndName": address.streetTypeAndName,
    "buildingNumber": address.buildingNumber,
    "apartmentOrFloor": address.apartmentOrFloor,
    "neighborhood": address.neighborhood,
    "postalCode": address.postalCode,
    "city": address.city,
    "state": address.state,
    "country": address.country,
    "latitude": coordinates.latitude,
    "longitude": coordinates.longitude,
  };

  factory ClusterModel.fromEntity(ClusterEntity cluster) {
    return ClusterModel(
      uid: cluster.uid,
      legalId: cluster.legalId,
      clustername: cluster.clustername,
      description: '',
      type: cluster.type,
      address: cluster.address,
      coordinates: cluster.coordinates, 
    );
  }
  
  ClusterEntity toEntity() {
    return ClusterEntity(
      uid: uid,
      legalId: legalId,
      clustername: clustername,
      description: description,
      type: type,
      address: address,
      coordinates: coordinates,
  );
}
}
