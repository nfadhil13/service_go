import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/widgets/buttons/button_icon_type.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';

class ServiceGoButtonContent extends StatelessWidget {
  const ServiceGoButtonContent({
    super.key,
    required this.fillParent,
    required this.buttonIconType,
    required this.prefixIcon,
    required this.keepBalance,
    required this.sServiceGofixIcon,
    required this.label,
    required this.textStyle,
  });

  final bool fillParent;
  final ButtonIconType buttonIconType;
  final Widget? prefixIcon;
  final bool keepBalance;
  final Widget? sServiceGofixIcon;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: fillParent ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: buttonIconType.mainAxisAlignment,
      children: [
        if (prefixIcon != null) prefixIcon!,
        if (keepBalance && prefixIcon == null && sServiceGofixIcon != null)
          ServiceGoHideWidget(child: sServiceGofixIcon!),
        Text(
          label,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        if (sServiceGofixIcon != null) sServiceGofixIcon!,
        if (keepBalance && sServiceGofixIcon == null && prefixIcon != null)
          ServiceGoHideWidget(child: prefixIcon!)
      ],
    );
  }
}
