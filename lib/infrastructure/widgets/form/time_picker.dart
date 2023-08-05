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

class SGTimePickerController extends ValueNotifier<TimeOfDay?> {
  SGTimePickerController({TimeOfDay? initialValue}) : super(initialValue);
}

class _SGTimePickerFieldState extends State<SGTimePickerField> {
  late final TextEditingController _textController;
  late SGTimePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SGTimePickerController();
    _textController = TextEditingController();
    _controller.addListener(_onValueChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onValueChange();
    });
  }

  void _showTimePicker() async {
    final result = await showTimePicker(
        context: context, initialTime: _controller.value ?? TimeOfDay.now());
    if (result != null) {
      _setValue(result);
    }
  }

  void _onValueChange() {
    _textController.text = _controller.value?.format(context) ?? "";
  }

  void _setValue(TimeOfDay? timeOfDay) {
    _controller.value = timeOfDay;
  }

  @override
  void dispose() {
    _controller.removeListener(_onValueChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
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
            return widget.validator?.call(_controller.value);
          },
          focusNode: widget.focusNode,
          readOnly: true,
          contentPadding: widget.padding,
        ),
      ),
    );
  }
}
