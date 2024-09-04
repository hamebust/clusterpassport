// settings_page.dart

// SettingsPage: página de configuración en la carpeta lib/features/app/settings
// SettingsPage: settings page in the lib/features/app/settings folder

// Todas las notas son en español e inglés
// All notes are in Spanish and English

// Sección de Paquetes
// Packages section

import 'package:cluster_passport/features/app/const/page_const.dart';
import 'package:cluster_passport/features/app/global/date/widgets/dialog_widget.dart';
import 'package:cluster_passport/features/app/global/date/widgets/profile_widget.dart';
import 'package:cluster_passport/features/user/presentation/cubits/auth/auth_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubits/get_single_user/get_single_user_cubit.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  final String? uid;

  // Constructor de la página de configuración
  // Configuration page constructor
  const SettingsPage({super.key, this.uid});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    // Cargar la información del usuario al iniciar la página
    // Load user information when the page starts
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: '${widget.uid}');
  }

  // Widget principal de la página de configuración
  // Main configuration page widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegación superior
      // Navigation bar
      appBar: AppBar(
        // Título de la página
        // Page title
        title: Text(S.of(context).Settings),
      ),
      body: Column(
        // Widget Padre que contiene los datos del usuario que inició sesión
        // Parent widget that contains the data of the logged-in user
        children: [
          _buildUserProfileSection(),

          // Caja separadora
          // Separator box
          const Divider(height: 20, thickness: 0.5, color: Colors.grey),

          // Área de configuraciones de la app
          // App configuration area

          // Cuenta
          // Account
          _settingsItemWidget(
            title: S.of(context).Account,
            description: S.of(context).settingsItemWidget_text01,
            icon: Icons.key,
            onTap: () {
              // Acción al presionar el ítem de cuenta
              // Action when the account item is tapped
            },
          ),

          // Privacidad
          // Privacy
          _settingsItemWidget(
            title: S.of(context).Privacy,
            description: S.of(context).settingsItemWidget_text02,
            icon: Icons.lock,
            onTap: () {
              // Acción al presionar el ítem de privacidad
              // Action when the privacy item is tapped
            },
          ),

          // Chats
          // Chats
          _settingsItemWidget(
            title: S.of(context).Chats,
            description: S.of(context).settingsItemWidget_text03,
            icon: Icons.message,
            onTap: () {
              // Acción al presionar el ítem de chats
              // Action when the chats item is tapped
            },
          ),

          // Cerrar sesión
          // Logout
          _settingsItemWidget(
            title: S.of(context).Logout,
            description: S.of(context).settingsItemWidget_text04,
            icon: Icons.exit_to_app,
            onTap: () {
              displayAlertDialog(
                context,
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).loggedOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.welcomePage, (route) => false);
                },
                confirmTitle: S.of(context).Logout,
                content: "Logout_confirmation_message",
              );
            },
          ),
        ],
      ),
    );
  }

  // Construye la sección del perfil del usuario
  // Builds the user profile section
  Widget _buildUserProfileSection() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if (state is GetSingleUserLoaded) {
            final singleUser = state.singleUser;

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConst.editProfilePage,
                    arguments: singleUser);
              },
              child: Row(              
              children: [
                // Foto de perfil
                // Profile picture
                SizedBox(
                    width: 65,
                    height: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.5),
                      child: profileWidget(imageUrl: singleUser.profileUrl),
                    ),
                  ),

                const SizedBox(width: 10),

                // Información del usuario
                // User information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${singleUser.username}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${singleUser.status}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
              ),
            );
          }

          // Estado de carga o error
          // Loading or error state
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.editProfilePage);
                },
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.5),
                    child: profileWidget(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "...",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "...",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget que construye los ítems de configuración
  // Widget that builds the configuration items
  Widget _settingsItemWidget({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              icon,
              color: greyColor,
              size: 25,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(color: greyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
