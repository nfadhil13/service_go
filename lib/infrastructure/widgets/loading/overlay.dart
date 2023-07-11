import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/widgets/loading/circular.dart';

class SGLoadingOverlay extends StatelessWidget {
  final Color? circularColor;
  final double? radius;
  final bool isInitialyLoading;
  final Duration? loadingDuration;
  final int numberOfDots;
  final double textToCircularSpacing;
  const SGLoadingOverlay(
      {super.key,
      this.circularColor,
      this.radius,
      this.textToCircularSpacing = 12,
      this.loadingDuration = const Duration(milliseconds: 500),
      this.numberOfDots = 5,
      this.isInitialyLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: SGCircularLoading(
        color: circularColor ?? context.color.primary,
        radius: radius ?? 24,
      ),
    );
  }
}
