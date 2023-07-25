import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/ext/date_ext.dart';

class SGDateTimeController extends ValueNotifier<DateTime?> {
  SGDateTimeController({DateTime? initialValue}) : super(initialValue);

  // Getter to access the current DateTime value
  DateTime? get dateTimeValue => value;

  // Setter to update the DateTime value
  set dateTimeValue(DateTime? newValue) {
    value = newValue;
  }
}

class SGDateTimeField extends StatefulWidget {
  final SGDateTimeController? controller;

  final String? label;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  const SGDateTimeField({
    super.key,
    this.controller,
    this.minimumDate,
    this.maximumDate,
    this.label,
  });

  @override
  State<SGDateTimeField> createState() => _SGDateTimeFieldState();
}

class _SGDateTimeFieldState extends State<SGDateTimeField> {
  late TextEditingController _dateTextController;
  late final SGDateTimeController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController with the current value from the controller (if provided)
    _dateTextController = TextEditingController();

    _controller = widget.controller ?? SGDateTimeController();
    // Listen to changes in the controller value and update the TextEditingController
    _controller.addListener(_onDateChangeListener);
  }

  void _onDateChangeListener() {
    _dateTextController.text = _controller.dateTimeValue?.let((value) {
          final date = value.dateStringForm(pattern: 'dd, MMMM yyyy');
          final hour = value.hourStringForm();
          return "$date. Pukul $hour";
        }) ??
        '';
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    // Show the date picker when the text field is tapped
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.controller?.dateTimeValue ?? DateTime.now(),
      firstDate: widget.minimumDate ?? DateTime(2000),
      lastDate: widget.maximumDate ?? DateTime(2101),
    );

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        _controller.dateTimeValue = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SGTextField(
      label: widget.label,
      controller: _dateTextController,
      readOnly: true, // Set it to true to prevent editing
      onTap: _selectDateTime,
    );
  }
}
