import 'package:flutter/cupertino.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';

class SGCircularLoading extends StatelessWidget {
  final Color? color;
  final double? radius;
  const SGCircularLoading({super.key, this.color, this.radius});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius ?? 20,
      color: color ?? context.color.primary,
    );
  }
}
