import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/widgets/form/time_picker.dart';
import 'package:sizer/sizer.dart';

class SGTimePickerData {
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  SGTimePickerData({this.startTime, this.endTime});
}

class SGTimeRangePickerField extends StatefulWidget {
  final SGTimePickerData? initialValue;
  final String? startLabel;
  final String? endLabel;
  final String? title;
  final BoxDecoration? decoration;
  final EdgeInsets? contentPadding;
  final num? titleSpacing;
  final TextStyle? titleStyle;
  const SGTimeRangePickerField(
      {super.key,
      this.initialValue,
      this.startLabel,
      this.endLabel,
      this.title,
      this.decoration,
      this.contentPadding,
      this.titleSpacing,
      this.titleStyle});

  @override
  State<SGTimeRangePickerField> createState() => _SGTimeRangePickerFieldState();
}

class _SGTimeRangePickerFieldState extends State<SGTimeRangePickerField> {
  final SGTimePickerController _startController = SGTimePickerController();
  final SGTimePickerController _endController = SGTimePickerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    return Container(
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
                initialValue: widget.initialValue?.startTime,
                controller: _startController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                initialValue: widget.initialValue?.endTime,
                controller: _endController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              )),
            ],
          )
        ],
      ),
    );
  }
}
