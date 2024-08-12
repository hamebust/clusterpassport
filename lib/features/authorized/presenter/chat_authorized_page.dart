import 'package:cluster_passport/features/authorized/presenter/chat_authorized_page%20copy.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatAuthorizedPage extends StatefulWidget {
  const ChatAuthorizedPage({super.key});

  @override
  State<ChatAuthorizedPage> createState() => _ChatAuthorizedPageState();
}

class _ChatAuthorizedPageState extends State<ChatAuthorizedPage> {
  String _selectedTimeType = 'Por lapso';
  String _selectedVisitType = 'Personal (visita privada)';
  String _visitReason = 'motivo de la visita';
  DateTime _visitStartTime = DateTime.now();
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
      if (newValue != null) {
        _selectedVisitType = newValue;
      }
    });
  }

  void _updateTimeType(String? newValue) {
    setState(() {
      if (newValue != null) {
        _selectedTimeType = newValue;
      }
    });
  }
}

