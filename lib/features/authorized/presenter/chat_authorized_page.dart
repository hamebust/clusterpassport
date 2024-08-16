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
                  onDateStartSelected: (DateTime dateTime) {
                    setState(() {
                      _visitStartTime = dateTime;
                    });
                  },
                  onDateEndSelected: (DateTime dateTime) {
                    setState(() {
                      _visitEndTime = dateTime;
                    });
                  },
                  onTimeStartSelected: (DateTime dateTime) {
                    setState(() {
                      // Combina la fecha seleccionada con la hora seleccionada
                      _visitStartTime = DateTime(
                        _visitStartTime?.year ?? dateTime.year,
                        _visitStartTime?.month ?? dateTime.month,
                        _visitStartTime?.day ?? dateTime.day,
                        dateTime.hour,
                        dateTime.minute,
                      );
                    });
                  },
                  onTimeEndSelected: (DateTime dateTime) {
                    setState(() {
                      // Combina la fecha seleccionada con la hora seleccionada
                      _visitEndTime = DateTime(
                        _visitEndTime?.year ?? dateTime.year,
                        _visitEndTime?.month ?? dateTime.month,
                        _visitEndTime?.day ?? dateTime.day,
                        dateTime.hour,
                        dateTime.minute,
                      );
                    });
                  },
                  onVisitTypeSelected: _updateVisitType,
                  onTimeTypeSelected: _updateTimeType,
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
  final ValueChanged<DateTime> onDateStartSelected;
  final ValueChanged<DateTime> onDateEndSelected;
  final ValueChanged<DateTime> onTimeStartSelected;
  final ValueChanged<DateTime> onTimeEndSelected;
  final ValueChanged<String?> onVisitTypeSelected;
  final ValueChanged<String?> onTimeTypeSelected;

  const VisitInformation({
    super.key,
    required this.timeType,
    required this.visitType,
    required this.visitReason,
    required this.visitStartTime,
    required this.visitEndTime,
    required this.accessCode,
    required this.onDateStartSelected,
    required this.onDateEndSelected,
    required this.onTimeStartSelected,
    required this.onTimeEndSelected,
    required this.onVisitTypeSelected,
    required this.onTimeTypeSelected,
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
          Row(
            children: [
              const Text('Visita:'),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: visitType,
                  hint: const Text('Visita'),
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
                  onChanged: onTimeTypeSelected,
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
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _selectDate(context, onDateStartSelected);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: visitStartTime != null
                                ? 'Fecha inicio: \n${DateFormat('yyyy-MM-dd').format(visitStartTime!)}'
                                : 'Fecha inicio: \n',
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _selectDate(context, onDateEndSelected);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: visitEndTime != null
                                ? 'Fecha fin: \n${DateFormat('yyyy-MM-dd').format(visitEndTime!)}'
                                : 'Fecha fin: \n',
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _selectTime(context, onTimeStartSelected);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: visitStartTime != null
                                ? 'Hora inicio: \n${DateFormat('HH:mm').format(visitStartTime!)}'
                                : 'Hora inicio: \n',
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _selectTime(context, onTimeEndSelected);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: visitEndTime != null
                                ? 'Hora fin: \n${DateFormat('HH:mm').format(visitEndTime!)}'
                                : 'Hora fin: \n',
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
        onTimeEndSelected(newEndTime);
      },
      child: Text('$hours h'),
    );
  }
 
  Future<void> _selectDate(
      BuildContext context, ValueChanged<DateTime> onSelected) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2034),
    );
    if (pickedDate != null) {
      onSelected(pickedDate);
    }
  }

  Future<void> _selectTime(
      BuildContext context, ValueChanged<DateTime> onSelected) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final DateTime finalDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      onSelected(finalDateTime);
    }
  }
}
