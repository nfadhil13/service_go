import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/widgets/form/time_picker.dart';
import 'package:sizer/sizer.dart';

class SGTimePickerData extends Equatable {
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  const SGTimePickerData({this.startTime, this.endTime});

  @override
  List<Object?> get props => [startTime, endTime];
}

class SGTimeRangePickerField extends StatefulWidget {
  final SGTimePickerData? initialValue;
  final String? startLabel;
  final String? endLabel;
  final String? title;
  final String? Function(SGTimePickerData data)? validator;
  final SGTimeRangePickerFieldController? controller;
  final BoxDecoration? decoration;
  final EdgeInsets? contentPadding;
  final num? titleSpacing;
  final TextStyle? titleStyle;
  const SGTimeRangePickerField(
      {super.key,
      this.controller,
      this.initialValue,
      this.startLabel,
      this.endLabel,
      this.title,
      this.decoration,
      this.contentPadding,
      this.titleSpacing,
      this.titleStyle,
      this.validator});

  @override
  State<SGTimeRangePickerField> createState() => _SGTimeRangePickerFieldState();
}

class SGTimeRangePickerFieldController extends ValueNotifier<SGTimePickerData> {
  SGTimeRangePickerFieldController(
      {SGTimePickerData initialValue = const SGTimePickerData()})
      : super(initialValue);
}

class _SGTimeRangePickerFieldState extends State<SGTimeRangePickerField> {
  late final SGTimeRangePickerFieldController _controller;
  late final SGTimePickerController _startController;
  late final SGTimePickerController _endController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SGTimeRangePickerFieldController();

    _startController = SGTimePickerController(
        initialValue:
            widget.initialValue?.startTime ?? _controller.value.startTime);
    _endController = SGTimePickerController(
        initialValue:
            widget.initialValue?.endTime ?? _controller.value.endTime);
    _startController.addListener(_onStartChange);
    _endController.addListener(_onEndChange);
  }

  void _onStartChange() {
    final currentValue = _controller.value;
    final newStartValue = _startController.value;
    final currentEndValue = currentValue.endTime;
    if (currentEndValue != null &&
        newStartValue != null &&
        newStartValue.isAfter(currentEndValue)) {
      context.messenger.showErrorSnackbar(
          "Waktu mulai tidak boleh lebih dari waktu selesai");
      return;
    }
    _controller.value = SGTimePickerData(
        startTime: newStartValue, endTime: currentValue.endTime);
  }

  void _onEndChange() {
    final currentValue = _controller.value;
    final newEndValue = _endController.value;
    final currentStartValue = currentValue.startTime;
    if (newEndValue != null &&
        currentStartValue != null &&
        newEndValue.isBefore(currentStartValue)) {
      context.messenger.showErrorSnackbar(
          "Waktu selesai tidak boleh kurang dari waktu mulai");
      return;
    }
    _controller.value =
        SGTimePickerData(startTime: currentStartValue, endTime: newEndValue);
  }

  @override
  void dispose() {
    _startController.removeListener(_onStartChange);
    _endController.removeListener(_onEndChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    return FormField(
        validator: (_) => widget.validator?.call(_controller.value),
        builder: (state) {
          return Column(
            children: [
              Container(
                decoration: widget.decoration,
                padding: widget.contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: widget.titleSpacing?.toDouble() ?? .5.h),
                          child: Text(
                            title,
                            style: widget.titleStyle ?? context.text.labelLarge,
                          )),
                    Row(
                      children: [
                        Expanded(
                            child: SGTimePickerField(
                          label: widget.startLabel,
                          controller: _startController,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        )),
                        const SizedBox(width: 12),
                        Container(
                          width: 10,
                          height: 2,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: SGTimePickerField(
                          label: widget.endLabel,
                          controller: _endController,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        )),
                      ],
                    )
                  ],
                ),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: context.text.bodySmall
                      ?.copyWith(color: context.color.error),
                )
            ],
          );
        });
  }
}

extension _TimeOfDayExtensions on TimeOfDay {
  bool isAfter(TimeOfDay other) {
    if (this.hour > other.hour) {
      return true;
    } else if (this.hour == other.hour && this.minute > other.minute) {
      return true;
    }
    return false;
  }

  bool isBefore(TimeOfDay other) {
    if (this.hour < other.hour) {
      return true;
    } else if (this.hour == other.hour && this.minute < other.minute) {
      return true;
    }
    return false;
  }
}
