import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/widgets/form/decoration.dart';
import 'package:sizer/sizer.dart';

class SGTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? desc;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final int minLine;
  final int maxLine;
  final bool readOnly;
  final String? initialValue;
  final bool filled;
  final bool shownCounter;
  final Color? backgroundColor;
  final Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool? autofocus;
  final BorderRadius borderRadius;

  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;

  SGTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.focusNode,
    this.minLine = 1,
    this.autofocus,
    this.maxLine = 1,
    this.label = '',
    this.enabled,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.prefixIcon,
    this.inputType,
    this.desc,
    this.readOnly = false,
    this.backgroundColor,
    this.filled = false,
    this.onFieldSubmitted,
    this.textInputAction,
    this.initialValue,
    this.contentPadding,
    this.inputFormatters,
    this.onTap,
    this.shownCounter = false,
  })  : borderRadius = BorderRadius.circular(8),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          buildCounter: shownCounter
              ? (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) {
                  if (!isFocused) return null;
                  return Text("$currentLength/$maxLength");
                }
              : null,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          autofocus: autofocus ?? false,
          focusNode: focusNode,
          enabled: enabled ?? true,
          minLines: minLine,
          maxLines: maxLine,
          initialValue: initialValue,
          readOnly: readOnly,
          obscureText: obscureText ?? false,
          validator: validator,
          controller: controller,
          style: text.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          decoration: SGInputDecoration.inputDecoration(context,
              contentPadding: contentPadding,
              hintText: hintText,
              label: label,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              borderRadius: borderRadius),
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: inputType,
          onTap: onTap,
        ),
        if (desc != null) const SizedBox(height: 5.0),
        if (desc != null)
          Text(
            desc!,
            style: context.text.bodySmall,
          ),
      ],
    );
  }
}
