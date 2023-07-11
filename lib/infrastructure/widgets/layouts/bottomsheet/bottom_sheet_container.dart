import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';

class SGBottomSheetContainer extends StatelessWidget {
  final Widget child;
  const SGBottomSheetContainer({super.key, required this.child});

  static Future<T?> showBottomSheet<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T?>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (bottomSheetContext) {
          return SGBottomSheetContainer(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 56),
            child: child,
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: context.color.surface,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: child);
  }
}
