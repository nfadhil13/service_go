import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';

class SGTimePickerField extends StatefulWidget {
  final SGTimePickerController? controller;
  final FocusNode? focusNode;
  final TimeOfDay? initialValue;
  final EdgeInsets? padding;
  final TextStyle? textstyle;
  final String? label;
  final String? Function(TimeOfDay? value)? validator;

  const SGTimePickerField({
    super.key,
    this.focusNode,
    this.controller,
    this.initialValue,
    this.validator,
    this.padding,
    this.textstyle,
    this.label,
  });

  @override
  State<SGTimePickerField> createState() => _SGTimePickerFieldState();
}

class SGTimePickerController {
  _SGTimePickerFieldState? _state;

  SGTimePickerController();

  _init(
    _SGTimePickerFieldState state,
  ) {
    _state = state;
  }

  dispose() {
    _state = null;
  }

  TimeOfDay? get value => _state?._value;
}

class _SGTimePickerFieldState extends State<SGTimePickerField> {
  late final TextEditingController _textController;
  TimeOfDay? _value;

  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
    _textController = TextEditingController();
    _value = widget.initialValue;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _textController.text = _value?.format(context) ?? "";
    });
  }

  void _showTimePicker() async {
    final result = await showTimePicker(
        context: context, initialTime: _value ?? TimeOfDay.now());
    if (result != null) {
      _setValue(result);
    }
  }

  void _setValue(TimeOfDay? timeOfDay) {
    if (!mounted) return;
    _value = timeOfDay;
    _textController.text = timeOfDay?.format(context) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTimePicker();
      },
      child: AbsorbPointer(
        child: SGTextField(
          label: widget.label,
          controller: _textController,
          validator: (_) {
            return widget.validator?.call(_value);
          },
          focusNode: widget.focusNode,
          readOnly: true,
          contentPadding: widget.padding,
        ),
      ),
    );
  }
}
