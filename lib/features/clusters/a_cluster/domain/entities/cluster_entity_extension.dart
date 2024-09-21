// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'cluster_entity.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // Extensión para convertir un ClusterEntity en un documento para Firebase
// extension ClusterEntityExtension on ClusterEntity {
//   Map<String, dynamic> toDocument() {
//     return {
//       "clusterUid": clusterUid,
//       "clusterLegalId": clusterLegalId,
//       "clusterName": clusterName,
//       "clusterDescription": clusterDescription,
//       "clusterType": clusterType,
//       "clusterAddressStreetTypeAndName": clusterAddress.clusterAddressStreetTypeAndName,
//       "clusterAddressBuildingNumber": clusterAddress.clusterAddressBuildingNumber,
//       "clusterAddressApartmentOrFloor": clusterAddress.clusterAddressApartmentOrFloor,
//       "clusterAddressNeighborhood": clusterAddress.clusterAddressNeighborhood,
//       "clusterAddressPostalCode": clusterAddress.clusterAddressPostalCode,
//       "clusterAddressCity": clusterAddress.clusterAddressCity,
//       "clusterAddressState": clusterAddress.clusterAddressState,
//       "clusterAddressCountry": clusterAddress.clusterAddressCountry,
//       "latitude": clusterCoordinates.latitude,
//       "longitude": clusterCoordinates.longitude,
//       "clusterAdministrators": clusterAdministrators,
//       "clusterClients": clusterClients,
//       "clusterSecurityGuard": clusterSecurityGuard,
//     };
//   }

//   // Extensión para crear un ClusterEntity desde un DocumentSnapshot de Firebase
//   static ClusterEntity fromSnapshot(DocumentSnapshot snapshot) {
//     final snap = snapshot.data() as Map<String, dynamic>;

//     return ClusterEntity(
//       clusterUid: snap['clusterUid'],
//       clusterLegalId: snap['clusterLegalId'] ?? '',
//       clusterName: snap['clusterName'] ?? '',
//       clusterDescription: snap['clusterDescription'] ?? '',
//       clusterType: snap['clusterType'] ?? 'Physical',
//       clusterAddress: ClusterAddress(
//         clusterAddressStreetTypeAndName: snap['clusterAddressStreetTypeAndName'] ?? '',
//         clusterAddressBuildingNumber: snap['clusterAddressBuildingNumber'] ?? '',
//         clusterAddressApartmentOrFloor: snap['clusterAddressApartmentOrFloor'] ?? '',
//         clusterAddressNeighborhood: snap['clusterAddressNeighborhood'] ?? '',
//         clusterAddressPostalCode: snap['clusterAddressPostalCode'] ?? '',
//         clusterAddressCity: snap['clusterAddressCity'] ?? '',
//         clusterAddressState: snap['clusterAddressState'] ?? '',
//         clusterAddressCountry: snap['clusterAddressCountry'] ?? '',
//       ),
//       clusterCoordinates: LatLng(
//         snap['latitude'] ?? 0.0,
//         snap['longitude'] ?? 0.0,
//       ),
//       clusterAdministrators: List<String>.from(snap['clusterAdministrators'] ?? []),
//       clusterClients: List<String>.from(snap['clusterClients'] ?? []),
//       clusterSecurityGuard: List<String>.from(snap['clusterSecurityGuard'] ?? []),
//     );
//   }
// }
