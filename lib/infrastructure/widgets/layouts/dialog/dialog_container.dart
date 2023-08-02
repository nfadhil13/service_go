import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';

part 'confirmation_dialog.dart';
part 'action_dialog.dart';
part 'information_dialog.dart';

class SGDialogContainer extends StatelessWidget {
  final double maxHeightPercentage;
  final Widget child;
  const SGDialogContainer(
      {super.key, required this.maxHeightPercentage, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.color;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.width * .05, vertical: 0),
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: size.height * maxHeightPercentage,
                        minHeight: 0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: colorTheme.surface,
                          borderRadius: BorderRadius.circular(12)),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
