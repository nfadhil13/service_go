part of '../servis_customer_detail_screen.dart';

class _Information extends StatelessWidget {
  const _Information({
    super.key,
    required this.servisDetail,
  });

  final ServisDetail servisDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ServisDetail(servis: servisDetail.servis),
            18.verticalSpace,
            _Layanan(layananList: servisDetail.servis.layanan),
            12.verticalSpace,
            _Notes(note: servisDetail.servis.catatan),
            12.verticalSpace,
            _Bengkel(bengkelProfile: servisDetail.bengkelProfile),
            SGHideWidget(
                child:
                    _Actions(servisStatusData: servisDetail.servis.statusData))
          ],
        ),
      ),
    );
  }
}
