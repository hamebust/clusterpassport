import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatAuthorizedPage extends StatefulWidget {
  const ChatAuthorizedPage({super.key});

  @override
  State<ChatAuthorizedPage> createState() => _ChatAuthorizedPageState();
}

class _ChatAuthorizedPageState extends State<ChatAuthorizedPage> {
  String? _selectedTimeType = 'Por lapso';
  String? _selectedVisitType = 'Personal (privada)';
  String _visitReason = 'motivo de la visita';
  DateTime? _visitStartTime = DateTime.now();
  DateTime? _visitEndTime;
  final String _accessCode = const Uuid().v4();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ambar Medina'),
            Text('Online',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Implement video call action
            },
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {
              // Implement call action
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              // Implement more options action
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Mensaje $index'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                VisitInformation(
                  timeType: _selectedTimeType,
                  visitType: _selectedVisitType,
                  visitReason: _visitReason,
                  visitStartTime: _visitStartTime,
                  visitEndTime: _visitEndTime,
                  accessCode: _accessCode,
                  onTimeStartSelected: (DateTime dateTime) {
                    setState(() {
                      _visitStartTime = dateTime;
                    });
                  },
                  onTimeFinSelected: (DateTime dateTime) {
                    setState(() {
                      _visitEndTime = dateTime;
                    });
                  },
                  onVisitTypeSelected: _updateVisitType,
                  onTimeTypeSelected: _updateTimeType, // Added this line
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            _visitReason = text;
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateVisitType(String? newValue) {
    setState(() {
      _selectedVisitType = newValue;
    });
  }

  void _updateTimeType(String? newValue) {
    setState(() {
      _selectedTimeType = newValue;
    });
  }
}

class VisitInformation extends StatelessWidget {
  final String? visitType;
  final String visitReason;
  final DateTime? visitStartTime;
  final DateTime? visitEndTime;
  final String accessCode;
  final String? timeType;
  final ValueChanged<DateTime> onTimeStartSelected;
  final ValueChanged<DateTime> onTimeFinSelected;
  final ValueChanged<String?> onVisitTypeSelected;
  final ValueChanged<String?> onTimeTypeSelected; // Added this line

  const VisitInformation({
    super.key,
    required this.timeType,
    required this.visitType,
    required this.visitReason,
    required this.visitStartTime,
    required this.visitEndTime,
    required this.accessCode,
    required this.onTimeStartSelected,
    required this.onTimeFinSelected,
    required this.onVisitTypeSelected,
    required this.onTimeTypeSelected, // Added this line
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Row(
          //  children: [
          //    if (visitReason.isNotEmpty)
          //      Expanded(
          //        child: Text('Motivo: $visitReason'),
          //      ),
          //  ],
          //),
          Row(
            children: [
              const Text('Visita:'),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: visitType,
                  hint: const Text('Visita'), //
                  items: <String>[
                    'Personal (privada)',
                    'Servicio o trabajador (pública)' 
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onVisitTypeSelected,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Tipo de tiempo:'),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: timeType,
                  hint: const Text('Selecciona el tipo de tiempo'),
                  items: <String>['Por lapso', 'Por horario', 'Permanente']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onTimeTypeSelected, // Updated this line
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (timeType == 'Por lapso')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHourButton(1, context),
                _buildHourButton(2, context),
                _buildHourButton(4, context),
                _buildHourButton(8, context),
              ],
            ),
          if (timeType == 'Por horario')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _selectDateTime(context, onTimeStartSelected);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: visitStartTime != null
                            ? 'Inicio: \n${DateFormat('yyyy-MM-dd HH:mm').format(visitStartTime!)}'
                            : 'Inicio: \n',
                        style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _selectDateTime(context, onTimeFinSelected);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: visitEndTime != null
                            ? 'Fin: \n${DateFormat('yyyy-MM-dd HH:mm').format(visitEndTime!)}'
                            : 'Fin: \n',
                        style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          //if (accessCode.isNotEmpty) Text('Código: $accessCode'),
        ],
      ),
    );
  }

  Widget _buildHourButton(int hours, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final now = DateTime.now();
        final newEndTime = now.add(Duration(hours: hours));
        onTimeStartSelected(now);
        onTimeFinSelected(newEndTime);
      },
      child: Text('$hours h'),
    );
  }

  Future<void> _selectDateTime(
      BuildContext context, ValueChanged<DateTime> onSelected) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2034),
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

        // Validación para onTimeStartSelected (inicio)
        if (onSelected == onTimeStartSelected &&
            finalDateTime.isBefore(DateTime.now())) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'La fecha de inicio debe ser la hora actual o posterior')),
          );
          return;
        }

        // Validación para onTimeFinSelected (fin)
        if (onSelected == onTimeFinSelected &&
            visitStartTime != null &&
            finalDateTime.isBefore(visitStartTime!)) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'La fecha de fin debe ser posterior a la fecha de inicio')),
          );
          return;
        }

        onSelected(finalDateTime);
      }
    }
  }
}
