import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitInformation extends StatefulWidget {
  final String? visitType;
  final String visitReason;
  final DateTime? visitStartTime;
  final DateTime? visitEndTime;
  final String accessCode;
  final String? timeType;
  final int? selectedHour;
  final ValueChanged<DateTime> onDateStartSelected;
  final ValueChanged<DateTime> onDateEndSelected;
  final ValueChanged<DateTime> onTimeStartSelected;
  final ValueChanged<DateTime> onTimeEndSelected;
  final ValueChanged<String?> onVisitTypeSelected;
  final ValueChanged<String?> onTimeTypeSelected;
  final ValueChanged<int> onHourSelected;

  // Nombre del usuario visitante principal
  final String mainVisitor;

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
    required this.selectedHour,
    required this.onHourSelected,
    required this.mainVisitor, // nuevo parámetro para el visitante principal
  });

  @override
  // ignore: library_private_types_in_public_api
  _VisitInformationState createState() => _VisitInformationState();
}

class _VisitInformationState extends State<VisitInformation> {
  List<String> secondaryVisitors = [];

  bool _isSelectedHour(int hours) {
    return widget.selectedHour == hours;
  }

  DateTime calculateEndTime(DateTime startTime, int hours) {
    return startTime.add(Duration(hours: hours));
  }

  Widget buildDateSelection(BuildContext context, String label, DateTime? dateTime, ValueChanged<DateTime> onSelected, bool isTime) {
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = isTime ? DateFormat.Hm(locale) : DateFormat.yMd(locale);
    final formattedDateTime = dateTime != null ? dateFormat.format(dateTime) : 'N/A';

    return Expanded(
      child: GestureDetector(
        onTap: () async {
          DateTime? selectedDateTime;
          if (isTime) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(dateTime ?? DateTime.now()),
            );
            if (time != null) {
              selectedDateTime = DateTime(
                dateTime?.year ?? DateTime.now().year,
                dateTime?.month ?? DateTime.now().month,
                dateTime?.day ?? DateTime.now().day,
                time.hour,
                time.minute,
              );
            }
          } else {
            final date = await showDatePicker(
              context: context,
              initialDate: dateTime ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              selectedDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                dateTime?.hour ?? DateTime.now().hour,
                dateTime?.minute ?? DateTime.now().minute,
              );
            }
          }
          if (selectedDateTime != null) {
            onSelected(selectedDateTime);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '$label: $formattedDateTime',
            style: const TextStyle(color: Colors.white),
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
          // Sección de Visitantes en un Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Texto 'Visitante Principal:' a la derecha
              const Text(
                'Visitante:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // ListTile a la izquierda
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(widget.mainVisitor),
                ),
              ),
              
            ],
          ),

          
          // Sección de Visitantes Secundarios en un Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Texto 'Visitantes Secundarios:' a la izquierda
              const Text(
                'Otros: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
          // Botón para agregar visitantes secundarios
          TextButton.icon(
            onPressed: () async {
              final String? newVisitor = await _showAddVisitorDialog(context);
              if (newVisitor != null && newVisitor.isNotEmpty) {
                setState(() {
                  secondaryVisitors.add(newVisitor);
                });
              }
            },
            icon: const Icon(Icons.add),
            label: const Text(''),
          ),

              // ListTile con la lista de visitantes secundarios a la derecha
              Expanded(
                child: secondaryVisitors.isEmpty
                    ? const Text('No hay visitantes secundarios.')
                    : Column(
                        children: secondaryVisitors.map((visitor) {
                          return ListTile(
                            leading: const Icon(Icons.person_outline),
                            title: Text(visitor),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                setState(() {
                                  secondaryVisitors.remove(visitor);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),


          // Campos existentes
          _buildDropdownRow(
            'Visita Tipo:',
            widget.visitType,
            ['Personal (privada)', 'Servicio (pública)'],
            widget.onVisitTypeSelected,
          ),
          _buildDropdownRow(
            'Tiempo Tipo:',
            widget.timeType,
            ['Por lapso', 'Por horario', 'Permanente'],
            (newValue) {
              widget.onTimeTypeSelected(newValue);
              if (newValue == 'Permanente') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('La visita será permanente a partir de hoy.')),
                );
              }
            },
          ),
          const SizedBox(height: 8),
          if (widget.timeType == 'Permanente' || widget.timeType == 'Por horario')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDateSelection(
                  context,
                  'Inicio',
                  widget.visitStartTime,
                  widget.onDateStartSelected,
                  false,
                ),
                buildDateSelection(
                  context,
                  'Hora Inicio',
                  widget.visitStartTime,
                  widget.onTimeStartSelected,
                  true,
                ),
              ],
            ),
          const SizedBox(height: 8),
          if (widget.timeType == 'Por lapso')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int hour in [1, 2, 4, 8])
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onHourSelected(hour);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSelectedHour(hour)
                              ? Colors.white10
                              : Colors.white70,
                        ),
                        child: Text('$hour h'),
                      ),
                    ),
                  ),
              ],
            ),
          if (widget.timeType == 'Por horario')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDateSelection(
                  context,
                  'Fin',
                  widget.visitEndTime,
                  widget.onDateEndSelected,
                  false,
                ),
                buildDateSelection(
                  context,
                  'Hora Fin',
                  widget.visitEndTime,
                  widget.onTimeEndSelected,
                  true,
                ),
              ],
            ),
          const SizedBox(height: 8),
          // Text('Código de Acceso:), ${widget.accessCode}'),
          const SizedBox(height: 8),
          Text('Motivo: ${widget.visitReason}'),
        ],
      ),
    );
  }

  Future<String?> _showAddVisitorDialog(BuildContext context) async {
    String? newVisitorName;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Visitante Secundario'),
          content: TextField(
            onChanged: (value) {
              newVisitorName = value;
            },
            decoration: const InputDecoration(hintText: 'Nombre del Visitante'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(newVisitorName);
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdownRow(
    String label,
    String? value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        const SizedBox(width: 16),
        DropdownButton<String?>(
          value: value,
          items: options
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
