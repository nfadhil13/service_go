import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';

class ServiceGoPasswordField extends StatefulWidget {
  final ValueValidator<String?> validator;
  final String label;
  final TextEditingController controller;
  const ServiceGoPasswordField(
      {super.key,
      required this.validator,
      required this.label,
      required this.controller});

  @override
  State<ServiceGoPasswordField> createState() => _ServiceGoPasswordFieldState();
}

class _ServiceGoPasswordFieldState extends State<ServiceGoPasswordField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return ServiceGoTextField(
      obscureText: _isPasswordHidden,
      suffixIcon: InkWell(
        onTap: () => setState(() {
          _isPasswordHidden = !_isPasswordHidden;
        }),
        child: Icon(
          _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
        ),
      ),
      validator: widget.validator,
      controller: widget.controller,
      label: widget.label,
    );
  }
}
