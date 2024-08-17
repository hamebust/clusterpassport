import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatAuthorizedPage extends StatefulWidget {
  const ChatAuthorizedPage({super.key});

  @override
  State<ChatAuthorizedPage> createState() => _ChatAuthorizedPageState();
}

class DateTimeLocale extends StatelessWidget {
  const DateTimeLocale({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat.yMd(locale.toString()).add_Hm(); // Locale-specific formatting
    final formattedDateTime = formatter.format(DateTime.now());

    return Text(formattedDateTime);
  }
}

class _ChatAuthorizedPageState extends State<ChatAuthorizedPage> {
  late String formattedDate;
  late String formattedTime;
  String? _selectedTimeType = 'Por lapso';
  String? _selectedVisitType = 'Personal (privada)';
  String _visitReason = 'motivo de la visita';
  DateTime? _visitStartTime = DateTime.now();
  DateTime? _visitEndTime;
  final String _accessCode = const Uuid().v4();
  int? _selectedHour; // Variable para almacenar el botón de hora seleccionado

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('EEEE, d MMM yyyy').format(DateTime.now());
    formattedTime = DateFormat('HH:mm').format(DateTime.now());
  }

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
                  selectedHour: _selectedHour,
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
                  onTimeTypeSelected: (newValue) {
                    setState(() {
                      _selectedTimeType = newValue;
                      if (newValue == 'Permanente') {
                        _visitStartTime = DateTime.now();
                      }
                    });
                  },
                  onHourSelected: (int hours) {
                    setState(() {
                      _selectedHour = hours;
                    });
                  },
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
}

class VisitInformation extends StatelessWidget {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String? visitType;
  final String visitReason;
  final DateTime? visitStartTime;
  final DateTime? visitEndTime;
  final String accessCode;
  final String? timeType;
  final int? selectedHour; // Variable para el botón de hora seleccionado
  final ValueChanged<DateTime> onDateStartSelected;
  final ValueChanged<DateTime> onDateEndSelected;
  final ValueChanged<DateTime> onTimeStartSelected;
  final ValueChanged<DateTime> onTimeEndSelected;
  final ValueChanged<String?> onVisitTypeSelected;
  final ValueChanged<String?> onTimeTypeSelected;
  final ValueChanged<int> onHourSelected; // Callback para seleccionar la hora

  VisitInformation({
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
    required this.selectedHour,
    required this.onHourSelected,
  });

  bool _isSelectedHour(int hours) {
    return selectedHour == hours;
  }

  DateTime calculateEndTime(DateTime startTime, int hours) {
    return startTime.add(Duration(hours: hours));
  }

  Widget buildDateSelection(BuildContext context, String label, DateTime? date,
      ValueChanged<DateTime> onSelected, bool showTime) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          if (showTime) {
            await _selectTime(context, onSelected, date);
          } else {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2034),
            );
            if (pickedDate != null) {
              onSelected(pickedDate);
            }
          }
        },
        child: RichText(
          text: TextSpan(
            text: date != null
                ? '$label: \n${DateFormat(showTime ? 'HH:mm' : 'yyyy-MM-dd').format(date)}'
                : '$label: \n',
            style: DefaultTextStyle.of(context).style,
          ),
        ),
      ),
    );
  }

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
              const SizedBox(
                width: 110,
                child: Text('Visita Tipo:'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: visitType,
                  hint: const Text('Visita'),
                  items: <String>[
                    'Personal (privada)',
                    'Servicio (pública)'
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
              const SizedBox(
                width: 110,
                child: Text('Tiempo Tipo:'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<String>(
                  value: timeType,
                  hint: const Text('Seleccione'),
                  items: <String>['Por lapso', 'Por horario', 'Permanente']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    onTimeTypeSelected(newValue);
                    if (newValue == 'Permanente') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('La visita será permanente a partir de hoy.'))
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (timeType == 'Por lapso')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHourButton(1, context, _isSelectedHour(1)),
                _buildHourButton(2, context, _isSelectedHour(2)),
                _buildHourButton(4, context, _isSelectedHour(4)),
                _buildHourButton(8, context, _isSelectedHour(8)),
              ],
            ),
          if (timeType == 'Por horario')
            Column(
              children: [
                Row(
                  children: [
                    buildDateSelection(context, 'Fecha inicio', visitStartTime,
                        onDateStartSelected, false),
                    const SizedBox(width: 8),
                    buildDateSelection(context, 'Fecha fin', visitEndTime,
                        onDateEndSelected, false),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    buildDateSelection(context, 'Hora inicio', visitStartTime,
                        onTimeStartSelected, true),
                    const SizedBox(width: 8),
                    buildDateSelection(context, 'Hora fin', visitEndTime,
                        onTimeEndSelected, true),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildHourButton(int hours, BuildContext context, bool isSelected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () {
        final now = DateTime.now();
        final newEndTime = calculateEndTime(now, hours);
        onTimeStartSelected(now);
        onTimeEndSelected(newEndTime);
        onHourSelected(hours); // Actualizar el botón de hora seleccionado
      },
      child: Text('$hours h'),
    );
  }

  Future<void> _selectTime(BuildContext context, ValueChanged<DateTime> onSelected, DateTime? initialDate) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialDate != null ? TimeOfDay.fromDateTime(initialDate) : TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        initialDate?.year ?? DateTime.now().year,
        initialDate?.month ?? DateTime.now().month,
        initialDate?.day ?? DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      onSelected(selectedDateTime);
    }
  }
}
