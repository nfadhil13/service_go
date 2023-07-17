import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/widgets/form/decoration.dart';
import 'package:sizer/sizer.dart';

class SGDropdown<T> extends StatefulWidget {
  final List<(String label, T data)> choices;
  final T? initialValue;
  final SGDropdownController? controller;
  final String label;
  final String? hintText;
  final String? desc;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(T?)? validator;
  final TextInputType? inputType;
  final int minLine;
  final int maxLine;
  final bool readOnly;
  final bool filled;
  final Color? backgroundColor;
  final Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool? autofocus;
  final BorderRadius? borderRadius;

  SGDropdown({
    super.key,
    required this.choices,
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
    this.contentPadding,
    this.initialValue,
  }) : borderRadius = BorderRadius.circular(8);

  @override
  State<SGDropdown<T>> createState() => _SGDropdownState<T>();
}

class SGDropdownController<T> {
  _SGDropdownState<T>? _state;
  SGDropdownController();

  _init(_SGDropdownState<T>? state) {
    _state = state;
  }

  dispose() {
    _state = null;
  }

  T? get value => _state?._value;
}

class _SGDropdownState<T> extends State<SGDropdown<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        items: widget.choices
            .map((e) => DropdownMenuItem(
                  value: e.$2,
                  child: Text(
                    e.$1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        isExpanded: true,
        value: _value,
        validator: widget.validator,
        decoration: SGInputDecoration.inputDecoration(context,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            contentPadding: widget.contentPadding,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
            label: widget.label,
            prefixIcon: widget.prefixIcon),
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        });
  }
}
