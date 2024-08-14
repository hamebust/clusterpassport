import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitInformation extends StatefulWidget {
  final String? visitType;
  final String visitReason;
  final DateTime? visitStartTime;
  final DateTime? visitEndTime;
  final String accessCode;
  final ValueChanged<DateTime> onTimeStartSelected;
  final ValueChanged<DateTime> onTimeFinSelected;
  final ValueChanged<String?> onVisitTypeSelected;

  const VisitInformation({
    super.key,
    required this.visitType,
    required this.visitReason,
    required this.visitStartTime,
    required this.visitEndTime,
    required this.accessCode,
    required this.onTimeStartSelected,
    required this.onTimeFinSelected,
    required this.onVisitTypeSelected,
  });

  @override
  State<VisitInformation> createState() => _VisitInformationState();
}

class _VisitInformationState extends State<VisitInformation> {
  String? _selectedTimeType;
  int? _selectedHours;

  void _updateTimeType(String? newValue) {
    setState(() {
      _selectedTimeType = newValue;
      _selectedHours = null; 
    });
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
          if (widget.visitReason.isNotEmpty)
            Text('Motivo: ${widget.visitReason}'),
          const SizedBox(height: 8),
          _buildDropdownRow(
            'Visita:',
            widget.visitType,
            ['Personal', 'Servicio'],
            widget.onVisitTypeSelected,
          ),
          const SizedBox(height: 8),
          _buildDropdownRow(
            'Tipo de tiempo:',
            _selectedTimeType,
            ['Por lapso', 'Por horario', 'Permanente'],
            _updateTimeType,
          ),
          const SizedBox(height: 8),
          if (_selectedTimeType == 'Por lapso')
            _buildHourSelectionRow(),
          if (_selectedTimeType == 'Por horario')
            _buildDateTimeSelectionRow(),
          if (widget.accessCode.isNotEmpty)
            Text('Código: ${widget.accessCode}'),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(
      String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButton<String>(
            value: value,
            hint: Text(label),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildHourSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [1, 2, 4, 8].map((hours) {
        return _buildHourButton(hours, context, _selectedHours == hours);
      }).toList(),
    );
  }

  Widget _buildDateTimeSelectionRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _selectDateTime(context, widget.onTimeStartSelected),
            child: RichText(
              text: TextSpan(
                text: widget.visitStartTime != null
                    ? 'Inicio: \n${DateFormat('yyyy-MM-dd HH:mm').format(widget.visitStartTime!)}'
                    : 'Inicio: \n',
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _selectDateTime(context, widget.onTimeFinSelected),
            child: RichText(
              text: TextSpan(
                text: widget.visitEndTime != null
                    ? 'Fin: \n${DateFormat('yyyy-MM-dd HH:mm').format(widget.visitEndTime!)}'
                    : 'Fin: \n',
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourButton(int hours, BuildContext context, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        final now = DateTime.now();
        final newEndTime = now.add(Duration(hours: hours));
        widget.onTimeStartSelected(now);
        widget.onTimeFinSelected(newEndTime);

        setState(() {
          _selectedHours = isSelected ? null : hours;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : null,
      ),
      child: Text('$hours h'),
    );
  }

  Future<void> _selectDateTime(
      BuildContext context, ValueChanged<DateTime> onSelected) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), // Changed to a more realistic date
      lastDate: DateTime(2030),   // Changed to a more realistic date
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
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

        if (onSelected == widget.onTimeStartSelected &&
            finalDateTime.isBefore(DateTime.now())) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('La fecha de inicio debe ser la hora actual o posterior')),
          );
          return;
        }

        if (onSelected == widget.onTimeFinSelected &&
            widget.visitStartTime != null &&
            finalDateTime.isBefore(widget.visitStartTime!)) {
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