import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';

class SGPasswordField extends StatefulWidget {
  final ValueValidator<String?> validator;
  final String label;
  final TextEditingController controller;
  const SGPasswordField(
      {super.key,
      required this.validator,
      required this.label,
      required this.controller});

  @override
  State<SGPasswordField> createState() => _SGPasswordFieldState();
}

class _SGPasswordFieldState extends State<SGPasswordField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return SGTextField(
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
