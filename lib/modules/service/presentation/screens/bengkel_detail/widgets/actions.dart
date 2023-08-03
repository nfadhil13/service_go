part of '../servis_bengkel_detail_screen.dart';

class _Actions extends StatelessWidget {
  final ServisDetail servisDetail;
  const _Actions({required this.servisDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.color.surface,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: .5,
            offset: Offset(0.0, 0), //(x,y)
            blurRadius: .2,
          ),
        ],
      ),
      child: _ActionsButton(servisDetail: servisDetail),
    );
  }
}

class _ActionsButton extends StatelessWidget {
  final ServisDetail servisDetail;
  const _ActionsButton({required this.servisDetail});

  @override
  Widget build(BuildContext context) {
    final servis = servisDetail.servis;
    final statusData = servis.statusData;
    switch (statusData) {
      case ServisStatusDiajukan():
        return const _ActionDiajukan();
      case ServisStatusDitolak():
        return _ActionDitolak(alasanPenolakan: statusData.alasanPenolakan);
      case ServisStatusPengajuanDiterima():
        return const _ActionTerimaUnit();
      case ServisStatusUnitDiterima():
        return const _ActionPemeriksaanUnit();
      case ServisStatusUnitDiPeriksa():
        return const _ActionPengajuanServis();
      case ServisStatusMenungguPengerjaan():
        return const _ActionsMulaiPengerjaan();
      default:
        return const SizedBox();
    }
  }
}
