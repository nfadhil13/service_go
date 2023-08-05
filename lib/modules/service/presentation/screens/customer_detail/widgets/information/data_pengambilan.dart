part of '../../servis_customer_detail_screen.dart';

class _DataPengambilan extends StatelessWidget {
  final DataPengambilanServis dataPengambilanServis;
  const _DataPengambilan({super.key, required this.dataPengambilanServis});

  String _printFullDateTime(DateTime dateTime) {
    return "${dateTime.dateStringForm(pattern: "d MMM yyyy")}, Pukul ${dateTime.hourStringForm()}";
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return SGExpandableContainer(
      color: dataPengambilanServis.isDibatalkan ? color.error : color.primary,
      title:
          "Data Pengambilan (${dataPengambilanServis.isDibatalkan ? "Dibatalkan" : "Selesai"})",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.verticalSpace,
          _Item(title: "PIC Bengkel", item: dataPengambilanServis.picBengkel),
          14.verticalSpace,
          _Item(
              title: "Nama Pengambil",
              item: dataPengambilanServis.namaPengambil),
          14.verticalSpace,
          _Item(
              title: "Tanggal Pengambilan",
              item:
                  _printFullDateTime(dataPengambilanServis.tanggalPengambilan)),
          14.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Catatan Perbaikan",
                style: context.text.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                dataPengambilanServis.catatan,
                style: context.text.bodySmall
                    ?.copyWith(color: context.color.onSurface),
              ),
            ],
          ),
          14.verticalSpace,
          SGMultiImageField(
            readOnly: true,
            initialImages: dataPengambilanServis.bukti,
            label: "Gambar Pendukung",
          ),
          14.verticalSpace,
        ],
      ),
    );
  }
}
