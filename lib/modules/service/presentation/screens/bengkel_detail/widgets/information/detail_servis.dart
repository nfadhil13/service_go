part of '../../servis_bengkel_detail_screen.dart';

class _DetailServis extends StatelessWidget {
  final ServisStatus status;
  final KeteranganServis keteranganServis;
  const _DetailServis(
      {super.key, required this.keteranganServis, required this.status});

  @override
  Widget build(BuildContext context) {
    return SGExpandableContainer(
      color: status.let((value) {
        final color = context.color;
        switch (value) {
          case ServisStatus.dibatalkan:
          case ServisStatus.konfirmasiServis:
            return color.error;
          case ServisStatus.siapDiambil:
          case ServisStatus.serviceSelesai:
            return color.onSurface;
          default:
            return color.primary;
        }
      }),
      title: status.let((value) {
        switch (value) {
          case ServisStatus.dibatalkan:
          case ServisStatus.konfirmasiServis:
            return "Detail Servis diajukan";
          case ServisStatus.siapDiambil:
          case ServisStatus.serviceSelesai:
            return "Detail Servis telah dikerjakan";
          case ServisStatus.menungguPengerjaan:
            return "Detail Servis akan dikerjakan";
          default:
            return "Detail Servis sedang dikerjakan";
        }
      }),
      child: Column(
        children: [
          14.verticalSpace,
          SGMultiImageField(
            readOnly: true,
            initialImages: keteranganServis.attachments,
            label: "Gambar Pendukung",
          ),
          14.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Perbaikan",
                style: context.text.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                keteranganServis.deskripsiServis,
                style: context.text.bodySmall
                    ?.copyWith(color: context.color.onSurface),
              ),
            ],
          )
        ],
      ),
    );
  }
}
