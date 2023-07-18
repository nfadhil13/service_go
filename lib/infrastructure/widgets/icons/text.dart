import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';

class SGIconText extends StatelessWidget {
  final double? size;
  const SGIconText({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text.displaySmall
        ?.copyWith(fontSize: size, color: Colors.black);
    return RichText(
        text: TextSpan(children: [
      const TextSpan(text: "Service"),
      TextSpan(text: "GO", style: text?.copyWith(color: color.primary))
    ], style: text));
  }
}
