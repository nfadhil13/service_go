part of '../../servis_bengkel_detail_screen.dart';

class _ServisDetail extends StatelessWidget {
  final Servis servis;
  const _ServisDetail({super.key, required this.servis});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Expanded(
            child: AutoSizeText(servis.namaMotor,
                style: text.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          ),
          ServisStatusChip(status: servis.status)
        ],
      ),
      8.verticalSpace,
      _StatusWarning(color: color, text: text),
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
    ]);
  }
}

class _StatusWarning extends StatelessWidget {
  const _StatusWarning({
    super.key,
    required this.color,
    required this.text,
  });

  final ColorScheme color;
  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String item;
  final CrossAxisAlignment? alignment;
  const _Item({required this.title, required this.item, this.alignment});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          item,
          style: text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
