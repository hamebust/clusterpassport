import 'package:flutter/material.dart';

class ChatAuthorizedPage extends StatefulWidget {
  const ChatAuthorizedPage({super.key});

  @override
  State<ChatAuthorizedPage> createState() => _ChatAuthorizedPageState();
}

class _ChatAuthorizedPageState extends State<ChatAuthorizedPage> {
  String _motivoVisita = '';
  DateTime? _tiempoVisita;
  final String _codigoAcceso = '123456'; // Genera un código de acceso real aquí

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ambar Medina'),
            Text('Online', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          // Widget para la información de la visita
          InformacionVisita(
            motivoVisita: _motivoVisita,
            tiempoVisita: _tiempoVisita,
            codigoAcceso: _codigoAcceso,
            onTimeSelected: (DateTime dateTime) {
              setState(() {
                _tiempoVisita = dateTime;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Mensaje $index'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        _motivoVisita = text;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Acción al presionar el icono de adjuntar
                  },
                  icon: const Icon(Icons.attach_file),
                ),
                IconButton(
                  onPressed: () {
                    // Acción al presionar el icono de enviar
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InformacionVisita extends StatelessWidget {
  final String motivoVisita;
  final DateTime? tiempoVisita;
  final String codigoAcceso;
  final ValueChanged<DateTime> onTimeSelected;

  const InformacionVisita({super.key, 
    required this.motivoVisita,
    required this.tiempoVisita,
    required this.codigoAcceso,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (motivoVisita.isNotEmpty)
            Text('Motivo: $motivoVisita'),
          if (tiempoVisita != null)
            Text('Tiempo: ${tiempoVisita!.toString()}'), // Formatea la fecha y hora
          if (codigoAcceso.isNotEmpty)
            Text('Código: $codigoAcceso'),
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );
              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  // ignore: use_build_context_synchronously
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  final DateTime finalDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  onTimeSelected(finalDateTime);
                }
              }
            },
            child: const Text('Seleccionar Tiempo'),
          ),
        ],
      ),
    );
  }
}