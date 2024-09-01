//SettingsPage: página de configuración en la carpeta lib/features/app/settings
//SettingsPage: settings page in the lib/features/app/settings folder

// Todas las notas son en español e inglés
// All notes are in spanish and english

//Sección de Paquetes
//Packages section

import 'package:cluster_passport/features/app/const/page_const.dart';
import 'package:cluster_passport/features/app/global/date/widgets/dialog_widget.dart';
import 'package:cluster_passport/features/app/global/date/widgets/profile_widget.dart';
import 'package:cluster_passport/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:cluster_passport/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:cluster_passport/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  final String? uid;

  //Constructor de la página de configuración
  //Configuration page constructor
  const SettingsPage({super.key, this.uid});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(uid: '${widget.uid}');
    super.initState();
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
          // Widget Padre que contiene los datos del usuario que inicio sesión
          // Parent widget that contains the user data that logged in
          children: [
            // Widget hijo que contiene la foto de perfil del usuario y el nombre de usuario
            // Child widget that contains the user profile picture and username
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
                builder: (context, state) {
                  if (state is GetSingleUserLoaded) {
                    final singleUser = state.singleUser;

                    return Row(
                      // Widget hijo que contiene la foto de perfil del usuario
                      // Child widget that contains the user profile picture
                      children: [
                        const SizedBox(
                          width: 10,
                        ),

                        //Caja separadora
                        //Separator box
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PageConst.editProfilePage,
                                arguments: singleUser);
                          },
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32.5),
                              child: profileWidget(
                                  imageUrl: singleUser.profileUrl),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Widget hijo que contiene el nombre de usuario y el código de seguridad
                        // Child widget that contains the username and security code
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
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Row(
                    // Widget hijo que contiene la foto de perfil del usuario
                    // Child widget that contains the user profile picture
                    children: [
                      const SizedBox(
                        width: 10,
                      ),

                      //Caja separadora
                      //Separator box
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageConst.editProfilePage);
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

                      // Widget hijo que contiene el nombre de usuario y el código de seguridad
                      // Child widget that contains the username and security code
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
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Caja separadora
            // Separator box
            const SizedBox(
              height: 2,
            ),

            Container(
              width: double.infinity,
              height: 0.5,
              color: greyColor.withOpacity(.4),
            ),

            // Caja separadora
            // Separator box
            const SizedBox(
              height: 10,
            ),

            //Area de configuraciones de la app
            //App configuration area

            //Cuenta
            //Account
            _settingsItemWidget(
              title: S.of(context).Account,
              description: S.of(context).settingsItemWidget_text01,
              icon: Icons.key,
              onTap: () {},
            ),

            //Privacidad
            //Privacy
            _settingsItemWidget(
                title: S.of(context).Privacy,
                description: S.of(context).settingsItemWidget_text02,
                icon: Icons.lock,
                onTap: () {}),

            //Chats
            //Chats
            _settingsItemWidget(
                title: S.of(context).Chats,
                description: S.of(context).settingsItemWidget_text03,
                icon: Icons.message,
                onTap: () {}),

            //Cerrar sesión
            //Logout
            _settingsItemWidget(
                title: S.of(context).Logout,
                description: S.of(context).settingsItemWidget_text04,
                icon: Icons.exit_to_app,
                onTap: () {
                  displayAlertDialog(
                    context,
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).loggedOut();
                      Navigator.pushNamedAndRemoveUntil(context, PageConst.welcomePage, (route) => false);
                    },
                    confirmTitle: S.of(context).Logout,
                    content: "Are you sure you want to logout?",
                  );
                }),
          ],
        ));
  }

  //Widget hijo que contiene la configuración de la app
  //Child widget that contains the app configuration
  _settingsItemWidget(
      // Parámetros de entrada
      // Input parameters
      {String? title,
      String? description,
      IconData? icon,
      VoidCallback? onTap}) {
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
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "$description",
                  style: const TextStyle(color: greyColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
