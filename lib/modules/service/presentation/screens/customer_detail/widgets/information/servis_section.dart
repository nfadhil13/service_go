part of '../../servis_customer_detail_screen.dart';

class _ServisDetail extends StatelessWidget {
  final Servis servis;
  const _ServisDetail({super.key, required this.servis});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(servis.namaMotor,
                    style:
                        text.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          24.horizontalSpace,
          _QRButton(
            servisId: servis.id.id.toString(),
          )
        ],
      ),
      24.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: _Item(title: "Nomor Pesanan", item: servis.id.id ?? "")),
          14.horizontalSpace,
          Expanded(child: _Item(title: "Plat Nomor", item: servis.platNomor)),
        ],
      ),
      24.verticalSpace,
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: _Item(
                  title: "Tanggal Servis",
                  item: servis.tanggalService.dateStringForm())),
          Expanded(
              child: _Item(
                  title: "Jam Servis",
                  item: servis.tanggalService.hourStringForm())),
        ],
      ),
      24.verticalSpace,
      _StatusWarning(color: color, text: text, servisStatus: servis.status)
    ]);
  }
}

class _StatusWarning extends StatelessWidget {
  final ServisStatus servisStatus;
  const _StatusWarning({
    super.key,
    required this.color,
    required this.text,
    required this.servisStatus,
  });

  final ColorScheme color;
  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Status Servis",
          style: context.text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        4.verticalSpace,
        ServisStatusChip(status: servisStatus),
        4.verticalSpace,
        InkWell(
          onTap: () => ServisStatusDescList.showAsDialog(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_sharp,
                color: color.error,
                size: 14,
              ),
              8.horizontalSpace,
              Text(
                "Lihat daftar status pesanan disini",
                style: text.bodySmall?.copyWith(color: color.outline),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String item;
  const _Item({required this.title, required this.item});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          title,
          style: context.text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        AutoSizeText(
          item,
          style: text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _QRButton extends StatelessWidget {
  final String servisId;
  const _QRButton({required this.servisId});

  @override
  Widget build(BuildContext context) {
    final color = context.color.primary;
    return InkWell(
      onTap: () => SGQRDialog.showAsDialog(context, qrData: servisId),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Icon(
              Icons.qr_code,
              size: 18.sp,
              color: color,
            ),
            Text(
              "Show QR",
              style: context.text.titleSmall?.copyWith(
                  fontSize: 8.sp, color: color, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
