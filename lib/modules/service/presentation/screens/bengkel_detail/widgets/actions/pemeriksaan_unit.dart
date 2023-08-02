part of '../../servis_bengkel_detail_screen.dart';

class _ActionPemeriksaanUnit extends StatelessWidget {
  const _ActionPemeriksaanUnit();

  void _mulaiPemeriksaan(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final isAccepted = await SGConfirmationDialog.launchAsync(context,
        title: "Mulai Pemeriksaan?",
        desc:
            "Dengan mengkonfirmasi pemeriksaan unit, anda akan mulai melakukan pengecekan terhadap unit");
    if (!isAccepted) return;
    cubit.updateServis(
      onErrorText: "Memulai pemeriksaan error, silahkan coba lagi",
      onSuccessText: "Berhasil status unit menjadi sendang diperiksa",
      currentServisUpdater: (currentServis) =>
          currentServis.copyWith(statusData: ServisStatusUnitDiPeriksa()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Periksa Unit",
          fillParent: true,
          onPressed: () => _mulaiPemeriksaan(context),
        ),
      ],
    );
  }
}
