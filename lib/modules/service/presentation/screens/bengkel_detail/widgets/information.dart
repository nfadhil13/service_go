part of '../servis_bengkel_detail_screen.dart';

class _Information extends StatelessWidget {
  final ServisDetail servisDetail;
  const _Information({required this.servisDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ServisDetail(servis: servisDetail.servis),
        18.verticalSpace,
        _Layanan(layananList: servisDetail.servis.layanan),
        24.verticalSpace,
        _Notes(note: servisDetail.servis.catatan),
      ],
    );
  }
}
