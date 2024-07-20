import 'dart:io';

import 'package:cluster_passport/features/app/const/app_const.dart';
import 'package:cluster_passport/features/app/global/date/widgets/profile_widget.dart';
import 'package:cluster_passport/features/app/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:cluster_passport/features/app/global/widgets/profile_widget.dart';
// import 'package:cluster_passport/features/app/home/home_page.dart';
// import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
// import 'package:cluster_passport/features/user/presentation/cubit/credential/credential_cubit.dart';
// import 'package:cluster_passport/storage/storage_provider.dart';

class InitialProfileSubmitPage extends StatefulWidget {
  const InitialProfileSubmitPage({super.key});

  @override
  State<InitialProfileSubmitPage> createState() =>
      _InitialProfileSubmitPageState();
}

class _InitialProfileSubmitPageState extends State<InitialProfileSubmitPage> {
  final TextEditingController _usernameController = TextEditingController();

  File? _image;
  Future selectImage() async {
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      final pickedFile = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          if (kDebugMode) {
            print("no image has been selected");
          }
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "Profile Info",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Please provide your name and an optional profile photo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: selectImage,
              child: SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: profileWidget(image: _image),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.only(top: 1.5),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: tabColor, width: 1.5))),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    hintText: "Username", border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitProfileInfo() {}

  // void _profileInfo({String? profileUrl}) {
  //   if (_usernameController.text.isNotEmpty) {
  //     BlocProvider.of<CredentialCubit>(context).submitProfileInfo(
  //         user: UserEntity(
  //           email: "",
  //           username: _usernameController.text,
  //           phoneNumber: widget.phoneNumber,
  //           status: "Hey There! I'm using WhatsApp Clone",
  //           isOnline: false,
  //           profileUrl: profileUrl,
  //         )
  //     );
  //   }
  // }
}
