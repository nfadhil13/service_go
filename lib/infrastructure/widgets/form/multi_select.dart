import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/form/decoration.dart';
import 'package:sizer/sizer.dart';

class SGMultiSelectItem<T> extends Equatable {
  final String name;
  final T data;

  const SGMultiSelectItem(this.name, this.data);

  @override
  List<Object?> get props => [name, data];
}

class SGMultiSelectField<T> extends StatefulWidget {
  final List<SGMultiSelectItem<T>> items;
  final String? Function(List<T>)? validator;
  final SGMultiSelectFieldController? controller;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final FocusNode? focusNode;
  final bool? autofocus;
  final BorderRadius? borderRadius;
  final String label;
  final String? hintText;
  final String? desc;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  const SGMultiSelectField(
      {super.key,
      required this.items,
      this.controller,
      this.validator,
      this.contentPadding,
      this.enabled,
      this.focusNode,
      this.autofocus,
      this.borderRadius,
      required this.label,
      this.hintText,
      this.desc,
      this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.height});

  @override
  State<SGMultiSelectField<T>> createState() => _SGMultiSelectFieldState<T>();
}

class SGMultiSelectFieldController<T> {
  _SGMultiSelectFieldState<T>? _state;

  _init(_SGMultiSelectFieldState<T> state) {
    _state = state;
  }

  List<T> get value => _state?._value.map((e) => e.data).toList() ?? [];
}

class _SGMultiSelectFieldState<T> extends State<SGMultiSelectField<T>> {
  List<SGMultiSelectItem<T>> _value = [];

  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
  }

  void _openDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<SGMultiSelectItem<T>>(
          items: widget.items.map((e) => MultiSelectItem(e, e.name)).toList(),
          initialValue: _value,
          searchable: true,
          onConfirm: (values) {
            setState(() {
              _value = values;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openDialog,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<List<SGMultiSelectItem<T>>>(
            items: [
              DropdownMenuItem(
                  value: _value,
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: _value
                          .mapIndexed((i, e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: SGElevatedButton(
                                  onPressed: () {},
                                  label: e.name,
                                  elevation: 0,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _value.removeAt(i);
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Icon(
                                        Icons.close,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 12),
                                  textStyle: context.text.labelSmall?.copyWith(
                                      color: context.color.onPrimary),
                                ),
                              ))
                          .toList(),
                    ),
                  ))
            ],
            isDense: false,
            isExpanded: true,
            value: _value,
            itemHeight: widget.height ?? 20.h,
            validator: (value) {
              return widget.validator
                  ?.call(value?.map((e) => e.data).toList() ?? []);
            },
            decoration: SGInputDecoration.inputDecoration(context,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                contentPadding: widget.contentPadding,
                hintText: widget.hintText,
                suffixIcon: widget.suffixIcon,
                label: widget.label,
                prefixIcon: widget.prefixIcon),
            onChanged: null),
      ),
    );
  }
}
