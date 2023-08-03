import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:sizer/sizer.dart';

class SGFieldDesc extends StatelessWidget {
  final String desc;
  const SGFieldDesc({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Text(
        desc,
        style: context.text.bodySmall?.copyWith(fontSize: 9.sp),
      ),
    );
  }
}
