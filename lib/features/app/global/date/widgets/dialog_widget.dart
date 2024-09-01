// dialog_widget.dart

// Cuadro de diálogo de alerta
// Alert dialog box

// Todas las notas son en español e inglés
// All notes are in Spanish and English

// Sección de Paquetes
// Packages section
import 'package:cluster_passport/features/app/theme/style.dart';
import 'package:flutter/material.dart';

/// Muestra un cuadro de diálogo de alerta con opciones de cancelación y confirmación.
/// Displays an alert dialog with cancel and confirm options.
///
/// [context] es el contexto de la aplicación donde se mostrará el cuadro de diálogo.
/// [context] is the application context where the dialog will be shown.
///
/// [onTap] es la función que se ejecuta cuando se presiona el botón de confirmación.
/// [onTap] is the function executed when the confirm button is pressed.
///
/// [confirmTitle] es el título del botón de confirmación.
/// [confirmTitle] is the title of the confirm button.
///
/// [content] es el contenido del cuadro de diálogo.
/// [content] is the content of the dialog.
void displayAlertDialog(
    BuildContext context, {
    required VoidCallback onTap,
    required String confirmTitle,
    required String content,
  }) {
  
  // Botón de cancelación
  // Cancel button
  Widget cancelButton = TextButton(
    child: const Text(
      "Cancel", 
      style: TextStyle(color: tabColor),
    ),
    onPressed: () {
      Navigator.pop(context); // Cierra el cuadro de diálogo
      // Closes the dialog box
    },
  );

  // Botón de confirmación
  // Confirm button
  Widget confirmButton = TextButton(
    onPressed: onTap, // Ejecuta la función proporcionada
    // Executes the provided function
    child: Text(
      confirmTitle, 
      style: const TextStyle(color: tabColor),
    ),
  );

  // Cuadro de diálogo de alerta
  // AlertDialog box
  AlertDialog alert = AlertDialog(
    backgroundColor: backgroundColor,
    content: Text(content),
    actions: [cancelButton, confirmButton],
  );

  // Mostrar el cuadro de diálogo
  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
