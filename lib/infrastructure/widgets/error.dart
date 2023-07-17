import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';

class SGError extends StatelessWidget {
  final String message;
  final VoidCallback? retry;
  const SGError({super.key, required this.message, this.retry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        SGElevatedButton(
            onPressed: retry,
            label: "Coba Lagi",
            backgroundColor: context.color.error)
      ],
    );
  }
}
