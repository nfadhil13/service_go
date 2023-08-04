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
      if (servis.waktuMulaiPengerjaan == null)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: _Item(
                    title: "Tanggal Servis (Estimasi)",
                    item: servis.tanggalService.dateStringForm())),
            Expanded(
                child: _Item(
                    title: "Jam Servis (Estimasi)",
                    item: servis.tanggalService.hourStringForm())),
          ],
        ),
      if (servis.waktuMulaiPengerjaan != null)
        _WaktuPengerjaan(
          waktuMulai: servis.waktuMulaiPengerjaan!,
          waktuSelesai: servis.waktuSelesaiPengerjaan,
        ),
    ]);
  }
}

class _WaktuPengerjaan extends StatelessWidget {
  final DateTime? waktuSelesai;
  final DateTime waktuMulai;
  const _WaktuPengerjaan({this.waktuSelesai, required this.waktuMulai});

  String _printFullDateTime(DateTime dateTime) {
    return "${dateTime.dateStringForm(pattern: "d MMM yyyy")}, Pukul ${dateTime.hourStringForm()}";
  }

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final waktuSelesai = this.waktuSelesai;
    if (waktuSelesai == null) {
      return Row(
        children: [
          Expanded(
              child: _Item(
                  title: "Mulai Pengerjaan",
                  item: _printFullDateTime(waktuMulai))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lama Pengerjaan",
                  style: context.text.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    SGHoursSinceStartWidget(
                        startDateTime: waktuMulai,
                        builder: (hours, minutes, seconds) {
                          final finalSeconds = seconds.toString().let((value) {
                            if (value.length > 1) return value;
                            return "0$value";
                          });
                          return Text(
                            "$hours:$minutes:$finalSeconds",
                            style: text.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          );
                        }),
                    8.horizontalSpace,
                    Text("(Masih Proses)",
                        style: text.bodySmall
                            ?.copyWith(fontWeight: FontWeight.normal))
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: _Item(
                title: "Mulai Pengerjaan",
                item: _printFullDateTime(waktuMulai))),
        Expanded(
            child: _Item(
                title: "Selesai Pengerjaan",
                item: _printFullDateTime(waktuSelesai))),
      ],
    );
  }
}

class _StatusWarning extends StatelessWidget {
  const _StatusWarning({
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
