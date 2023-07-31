import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/status/servis_status.dart';

const _list = ServisStatus.values;

class ServisStatusDescList extends StatelessWidget {
  const ServisStatusDescList({super.key});

  static Future<void> showAsDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => const SGDialogContainer(
            maxHeightPercentage: .8, child: ServisStatusDescList()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        child: Column(
          children: [
            Text(
              "Daftar Status",
              style: context.text.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            14.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _list.mapIndexed((i, e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${i + 1}."),
                        8.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ServisStatusChip(status: e),
                              6.verticalSpace,
                              Text(e.description)
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
