// InitialProfileSubmitPage: Formulario inicial de foto y nombre de usuario
// InitialProfileSubmitPage: Initial form for photo and username

// Todas las notas son en español e inglés
// All notes are in Spanish and English

import 'dart:io';
import 'package:cluster_passport/features/app/const/app_const.dart';
import 'package:cluster_passport/features/app/global/date/widgets/profile_widget.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/presentation/cubits/credential/credential_cubit.dart';
import 'package:cluster_passport/storage/storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class InitialProfileSubmitPage extends StatefulWidget {
  final String phoneNumber;
  const InitialProfileSubmitPage({super.key, required this.phoneNumber});

  @override
  State<InitialProfileSubmitPage> createState() => _InitialProfileSubmitPageState();
}

class _InitialProfileSubmitPageState extends State<InitialProfileSubmitPage> {
  final TextEditingController _usernameController = TextEditingController();
  File? _image;
  // ignore: unused_field
  bool _isProfileUpdating = false;

  // Seleccionar imagen desde la cámara
  // Select image from camera
  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          if (kDebugMode) {
            print("No image has been selected");
          }
        }
      });
    } catch (e) {
      toast("Some error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Profile Info",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please provide your name and an optional profile photo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: selectImage,
              child: SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: profileWidget(image: _image),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              margin: const EdgeInsets.only(top: 1.5),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: tabColor, width: 1.5)),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Username",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _submitProfileInfo,
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enviar información del perfil
  // Submit profile information
  void _submitProfileInfo() {
    if (_image != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
        file: _image!,
        onComplete: (onProfileUpdateComplete) {
          setState(() {
            _isProfileUpdating = onProfileUpdateComplete;
          });
        },
      ).then((profileImageUrl) {
        _profileInfo(profileUrl: profileImageUrl);
      });
    } else {
      _profileInfo(profileUrl: "");
    }
  }

  // Guardar información del perfil
  // Save profile information
  void _profileInfo({String? profileUrl}) {
    if (_usernameController.text.isNotEmpty) {
      BlocProvider.of<CredentialCubit>(context).submitProfileInfo(
        user: UserEntity(
          email: "",
          username: _usernameController.text,
          phoneNumber: widget.phoneNumber,
          status: "Hey There! I'm using Cluster Passport",
          isOnline: false,
          profileUrl: profileUrl,
        ),
      );
    }
  }
}
