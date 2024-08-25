
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitInformation extends StatelessWidget {
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
  });

  bool _isSelectedHour(int hours) {
    return selectedHour == hours;
  }

  DateTime calculateEndTime(DateTime startTime, int hours) {
    return startTime.add(Duration(hours: hours));
  }

  Widget buildDateSelection(
    BuildContext context, String label, DateTime? dateTime, Function(DateTime) onSelected, bool isTime) {
    
    final locale = Localizations.localeOf(context);
    final dateFormat = isTime ? DateFormat.Hm(locale.toString()) : DateFormat.yMd(locale.toString());
    final formattedDateTime = dateTime != null ? dateFormat.format(dateTime) : 'N/A';

    return Expanded(
      child: GestureDetector(
        onTap: () async {
          if (isTime) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(dateTime ?? DateTime.now()),
            );
            if (time != null) {
              final selectedDateTime = DateTime(
                dateTime?.year ?? DateTime.now().year,
                dateTime?.month ?? DateTime.now().month,
                dateTime?.day ?? DateTime.now().day,
                time.hour,
                time.minute,
              );
              onSelected(selectedDateTime);
            }
          } else {
            final date = await showDatePicker(
              context: context,
              initialDate: dateTime ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final selectedDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                dateTime?.hour ?? DateTime.now().hour,
                dateTime?.minute ?? DateTime.now().minute,
              );
              onSelected(selectedDateTime);
            }
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
          _buildDropdownRow('Visita Tipo:', visitType, ['Personal (privada)', 'Servicio (pública)'],
            onVisitTypeSelected,
          ),
          _buildDropdownRow('Tiempo Tipo:', timeType,
            ['Por lapso', 'Por horario', 'Permanente'],
            (newValue) {
              onTimeTypeSelected(newValue);
              if (newValue == 'Permanente') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('La visita será permanente a partir de hoy.')),

                );
              }
            },
          ),
          const SizedBox(height: 8),
          if (timeType == 'Permanente' || timeType == 'Por horario')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDateSelection(context, 'Inicio', visitStartTime, onDateStartSelected, false),
                buildDateSelection(context, 'Hora Inicio', visitStartTime, onTimeStartSelected, true),
              ],
            ),
          const SizedBox(height: 8),
          if (timeType == 'Por lapso')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int hour in [1, 2, 4, 8])
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          onHourSelected(hour);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSelectedHour(hour)
                              ? Colors.blueGrey
                              : Colors.grey,
                        ),
                        child: Text('$hour h'),
                      ),
                    ),
                  ),
              ],
            ),

          if (timeType == 'Por horario')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDateSelection(context, 'Fin', visitEndTime, onDateEndSelected, false),
                buildDateSelection(context, 'Hora Fin', visitEndTime, onTimeEndSelected, true),
              ],
            ),
          const SizedBox(height: 8),
          Text('Código de Acceso: $accessCode'),
          const SizedBox(height: 8),
          Text('Motivo: $visitReason'),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String label, String? value, List<String> options,
      ValueChanged<String?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        const SizedBox(width: 16),
        DropdownButton<String?>(

          value: value,
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}