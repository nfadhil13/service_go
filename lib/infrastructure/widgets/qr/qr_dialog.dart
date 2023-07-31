import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';

class SGQRDialog extends StatelessWidget {
  final String qrData;
  const SGQRDialog({super.key, required this.qrData});

  static Future<void> showAsDialog(BuildContext context,
          {required String qrData}) =>
      showDialog(
        context: context,
        builder: (context) => SGDialogContainer(
            maxHeightPercentage: .6, child: SGQRDialog(qrData: qrData)),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: QrImageView(
        data: qrData,
        version: QrVersions.auto,
        size: 320,
        gapless: false,
      ),
    );
  }
}
