import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cluster_passport/features/app/const/firebase_collection_const.dart';
import 'package:cluster_passport/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:cluster_passport/features/user/data/models/user_model.dart';
import 'package:cluster_passport/features/user/domain/entities/contact_entity.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Para mostrar mensajes toast
import 'package:logger/logger.dart'; // Para logging

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  final Logger logger = Logger();

  UserRemoteDataSourceImpl({required this.fireStore, required this.auth});

  String _verificationId = "";

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = fireStore.collection(FirebaseCollectionConst.users);
    final uid = await getCurrentUID();
    final newUser = UserModel(
      email: user.email,
      uid: uid,
      isOnline: user.isOnline,
      phoneNumber: user.phoneNumber,
      username: user.username,
      profileUrl: user.profileUrl,
      status: user.status,
    ).toDocument();

    try {
      final userDoc = await userCollection.doc(uid).get();
      if (!userDoc.exists) {
        await userCollection.doc(uid).set(newUser);
      } else {
        await userCollection.doc(uid).update(newUser);
      }
    } catch (e) {
      logger.e("Error occur while creating user", error: e);
      throw Exception("Error occur while creating user");
    }
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = fireStore.collection(FirebaseCollectionConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
    List<ContactEntity> contactsList = [];

    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      for (var contact in contacts) {
        contactsList.add(ContactEntity(
          name: contact.name,
          photo: contact.photo,
          phones: contact.phones,
        ));
      }
    }

    return contactsList;
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = fireStore
        .collection(FirebaseCollectionConst.users)
        .where("uid", isEqualTo: uid);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          smsCode: smsPinCode, verificationId: _verificationId);

      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        Fluttertoast.showToast(msg: "Invalid Verification Code");
      } else if (e.code == 'quota-exceeded') {
        Fluttertoast.showToast(msg: "SMS quota-exceeded");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Unknown exception please try again");
    }
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = fireStore.collection(FirebaseCollectionConst.users);

    Map<String, dynamic> userInfo = {};

    if (user.username?.isNotEmpty ?? false)
      userInfo['username'] = user.username;
    if (user.status?.isNotEmpty ?? false) userInfo['status'] = user.status;
    if (user.profileUrl?.isNotEmpty ?? false)
      userInfo['profileUrl'] = user.profileUrl;
    if (user.isOnline != null) userInfo['isOnline'] = user.isOnline;

    await userCollection.doc(user.uid).update(userInfo);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    phoneVerificationCompleted(AuthCredential authCredential) {
      logger.i(
          "Phone verified: Token ${authCredential.token} ${authCredential.signInMethod}");
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      logger.e(
          "Phone verification failed: ${firebaseAuthException.message}, ${firebaseAuthException.code}");
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      logger.i("Verification timeout: $verificationId");
    }

    phoneCodeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 120),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
