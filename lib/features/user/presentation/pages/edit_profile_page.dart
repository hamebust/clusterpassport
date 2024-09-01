// EditProfilePage: página de edición de perfil en la carpeta lib/features/app/settings
// EditProfilePage: profile editing page in the lib/features/app/settings folder

// Sección de Paquetes
// Packages section
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Importaciones de la aplicación
// App imports
import 'package:cluster_passport/features/app/const/app_const.dart';
import 'package:cluster_passport/features/app/global/date/widgets/profile_widget.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:cluster_passport/features/user/domain/entities/user_entity.dart';
import 'package:cluster_passport/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:cluster_passport/storage/storage_provider.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controladores de texto para los campos de usuario y estado
  // Text controllers for username and status fields
  late final TextEditingController _usernameController;
  late final TextEditingController _aboutController;

  // Imagen seleccionada del perfil
  // Selected profile image
  File? _image;

  // Indicador de actualización de perfil
  // Profile updating indicator
  bool _isProfileUpdating = false;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los datos actuales del usuario
    // Initialize controllers with current user data
    _usernameController = TextEditingController(text: widget.currentUser.username);
    _aboutController = TextEditingController(text: widget.currentUser.status);
  }

  @override
  void dispose() {
    // Liberamos los recursos de los controladores al eliminar el widget
    // Dispose controllers when the widget is removed
    _usernameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  // Función para seleccionar una imagen de la galería
  // Function to select an image from the gallery
  Future<void> selectImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print("No se ha seleccionado ninguna imagen.");
      }
    } catch (e) {
      toast("Ocurrió un error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileImageSection(),
            const SizedBox(height: 10),
            _buildProfileItem(
              controller: _usernameController,
              title: "Name",
              description: "Enter username",
              icon: Icons.person,
            ),
            _buildProfileItem(
              controller: _aboutController,
              title: "About",
              description: "Hey there I'm using Cluster Passport",
              icon: Icons.info_outline,
            ),
            _buildSettingsItemWidget(
              title: "Phone",
              description: "${widget.currentUser.phoneNumber}",
              icon: Icons.phone,
            ),
            const SizedBox(height: 40),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // Construye la sección de la imagen de perfil con opción para seleccionar una nueva
  // Builds the profile image section with an option to select a new one
  Widget _buildProfileImageSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: profileWidget(
                imageUrl: widget.currentUser.profileUrl,
                image: _image,
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: GestureDetector(
              onTap: selectImage,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: tabColor,
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: blackColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Construye un elemento del perfil editable con un campo de texto
  // Builds an editable profile item with a text field
  Widget _buildProfileItem({
    required TextEditingController controller,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return GestureDetector(
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(icon, color: greyColor, size: 25),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: description,
                      suffixIcon: const Icon(
                        Icons.edit_rounded,
                        color: tabColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construye un widget de configuración que muestra información no editable
  // Builds a settings widget displaying non-editable information
  Widget _buildSettingsItemWidget({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return GestureDetector(
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(icon, color: greyColor, size: 25),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Construye el botón de guardar y maneja la actualización del perfil
  // Builds the save button and handles profile update
  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _submitProfileInfo,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: tabColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: _isProfileUpdating
            ? const Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: whiteColor),
                ),
              )
            : const Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ),
    );
  }

  // Envía la información del perfil actualizada
  // Submits the updated profile information
  void _submitProfileInfo() {
    setState(() {
      _isProfileUpdating = true;
    });

    final profileImageUrlFuture = _image != null
        ? StorageProviderRemoteDataSource.uploadProfileImage(
            file: _image!,
            onComplete: (isComplete) => setState(() => _isProfileUpdating = isComplete),
          )
        : Future.value(widget.currentUser.profileUrl);

    profileImageUrlFuture.then((profileImageUrl) {
      _updateUserProfile(profileImageUrl: profileImageUrl);
    });
  }

  // Actualiza el perfil del usuario usando el cubit
  // Updates the user's profile using the cubit
  void _updateUserProfile({required String profileImageUrl}) {
    if (_usernameController.text.isNotEmpty) {
      final updatedUser = UserEntity(
        uid: widget.currentUser.uid,
        email: widget.currentUser.email,
        username: _usernameController.text,
        phoneNumber: widget.currentUser.phoneNumber,
        status: _aboutController.text,
        isOnline: widget.currentUser.isOnline,
        profileUrl: profileImageUrl,
      );

      BlocProvider.of<UserCubit>(context).updateUser(user: updatedUser).then((_) {
        toast("Profile updated");
        setState(() {
          _isProfileUpdating = false;
        });
      });
    }
  }
}
