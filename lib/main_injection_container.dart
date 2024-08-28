import 'package:cloud_firestore/cloud_firestore.dart';
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
}