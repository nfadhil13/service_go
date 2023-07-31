import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/utils/color_utils.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/status_desc/servis_status_desc.dart';

class ServisStatusChip extends StatelessWidget {
  final ServisStatus status;
  const ServisStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = ColorUtil.hexToColor(status.colorHex);
    return InkWell(
      onTap: () => ServisStatusDescList.showAsDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color.withOpacity(.08),
            border: Border.all(color: color)),
        child: Text(
          status.statusName,
          style: context.text.bodySmall?.copyWith(color: color),
        ),
      ),
    );
  }
}
