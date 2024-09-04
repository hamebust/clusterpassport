import 'package:cluster_passport/features/authorized/presentation/pages/chat/widgets/visit_information.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatAuthorizedPage extends StatefulWidget {
  const ChatAuthorizedPage({super.key});

  @override
  State<ChatAuthorizedPage> createState() => _ChatAuthorizedPageState();
}

class _ChatAuthorizedPageState extends State<ChatAuthorizedPage> {
  String? _selectedTimeType = 'Por lapso';
  String? _selectedVisitType = 'Personal (privada)';
  DateTime? _visitStartTime = DateTime.now();
  DateTime? _visitEndTime;
  final String _accessCode = const Uuid().v4();
  int? _selectedHour;
  final String _visitReason = '';  // VisitReason ahora está desvinculado

  // Variable que controla la visibilidad de VisitInformation
  bool _isVisitInfoVisible = false;

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
                // Botón para mostrar u ocultar VisitInformation
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVisitInfoVisible = !_isVisitInfoVisible;
                    });
                  },
                  child: Text(
                    _isVisitInfoVisible
                        ? 'Ocultar Autorización'
                        : 'Crear Autorización',
                  ),
                ),

                // Widget VisitInformation desplegable
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isVisitInfoVisible
                      ? VisitInformation(
                          mainVisitor: 'Ambar Medina',  // Nombre del visitante principal
                          key: const ValueKey<int>(1),
                          timeType: _selectedTimeType,
                          visitType: _selectedVisitType,
                          visitReason: _visitReason, // Aquí se pasa el visitReason
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
                        )
                      : const SizedBox(), // Cuando está oculto, no se muestra nada
                ),

                // TextField de Chat se muestra solo cuando VisitInformation está oculto
                if (!_isVisitInfoVisible)
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Escribe un mensaje',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file),
                      ),
                      IconButton(
                        onPressed: () {},
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
