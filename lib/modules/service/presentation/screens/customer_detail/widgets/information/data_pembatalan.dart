part of '../../servis_customer_detail_screen.dart';

class _DataPembatalan extends StatelessWidget {
  final ServisStatusDibatalkan statusData;
  const _DataPembatalan({required this.statusData});

  String _printFullDateTime(DateTime dateTime) {
    return "${dateTime.dateStringForm(pattern: "d MMM yyyy")}, Pukul ${dateTime.hourStringForm()}";
  }

  @override
  Widget build(BuildContext context) {
    return SGExpandableContainer(
        color: context.color.error,
        title: "Data Pembatalan Pesanan",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            18.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: _Item(
                      title: "Dibatalkan Oleh",
                      item: statusData.isDibatalkanBengkel
                          ? "Bengkel"
                          : "Pelanggan"),
                ),
                Expanded(
                  child: _Item(
                      title: "Pengembalian",
                      item: statusData.dataPengambilanServis == null
                          ? "Belum Diambil"
                          : "Sudah Diambil"),
                ),
              ],
            ),
            12.verticalSpace,
            _Item(title: "Alasan Pembatalan", item: statusData.alasan),
            12.verticalSpace,
            if (statusData.dataPengambilanServis != null)
              statusData.dataPengambilanServis!.let(
                (dataPengambilanServis) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    14.verticalSpace,
                    _Item(
                        title: "PIC Bengkel",
                        item: dataPengambilanServis.picBengkel),
                    14.verticalSpace,
                    _Item(
                        title: "Nama Pengambil",
                        item: dataPengambilanServis.namaPengambil),
                    14.verticalSpace,
                    _Item(
                        title: "Tanggal Pengambilan",
                        item: _printFullDateTime(
                            dataPengambilanServis.tanggalPengambilan)),
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
              )
          ],
        ));
  }
}
