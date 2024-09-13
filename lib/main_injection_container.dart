import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/app/const/firebase_collection_const.dart';
import 'package:cluster_passport/features/clusters/clusters_injection_container.dart';
import 'package:cluster_passport/features/user/user_injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl =  GetIt.instance;

Future<void> init() async {
  // Register FirebaseAuth singleton instance
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Register FirebaseFirestore singleton instance
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  try {
    // Initialize user dependencies
    await userInjectionContainer();
  } catch (e) {
    // Handle any errors that occur during user injection container initialization
    print('Error initializing user injection container: $e');
  }

  try {
    // Initialize cluster dependencies
    await clustersInjectionContainer();
  } catch (e) {
    // Handle any errors that occur during cluster injection container initialization
    print('Error initializing cluster injection container: $e');
  }
  try {
    // Crear la colección 'clusters' si no existe
    final clusterCollection = FirebaseFirestore.instance.collection(FirebaseCollectionConst.clusters);
    await clusterCollection.get().then((value) {
      if (value.docs.isEmpty) {
        clusterCollection.add({}); // Agrega un documento vacío para crear la colección
        print('Colección "clusters" creada correctamente');
      }
    });
  } catch (e) {
    // Manejar errores al crear la colección
    print('Error al crear la colección "clusters": $e');
  }

}