import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:sizer/sizer.dart';

class SGInputDecoration {
  static InputDecoration inputDecoration(BuildContext context,
      {Widget? prefixIcon,
      Widget? suffixIcon,
      String? label,
      required BorderRadius borderRadius,
      String? hintText,
      bool counter = false,
      EdgeInsets? contentPadding}) {
    final color = context.color;
    final text = context.text;
    return InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      labelText: label,
      suffixIconColor: color.outline,
      errorStyle:
          context.text.bodySmall?.copyWith(color: color.error, fontSize: 10.sp),
      labelStyle: text.bodySmall,
      alignLabelWithHint: false,
      errorMaxLines: 3,
      errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: color.error)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: color.error)),
      focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: color.primary)),
      enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: color.outline)),
      hintText: hintText,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
    );
  }
}
