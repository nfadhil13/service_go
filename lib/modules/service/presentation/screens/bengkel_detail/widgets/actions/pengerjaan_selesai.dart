part of '../../servis_bengkel_detail_screen.dart';

class _ActionPengerjaanSelesai extends StatelessWidget {
  const _ActionPengerjaanSelesai();

  void _selesaikanPengerjaan(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final isAccepted = await SGConfirmationDialog.launchAsync(context,
        title: "Selesaikan Pengerjaan?",
        desc:
            "Apakah anda yakin bahwa pengerjaan sudah selesai? Silahkan hubungi pelanggan untuk mengambil unit");
    if (!isAccepted) return;
    final newStatus = ServisStatusSiapDiambil();
    cubit.updateServis(
      onErrorText: "Menyelesaikan pengerjaan error, silahkan coba lagi",
      onSuccessText: "Berhasil menyelesaikan pengerjaan",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: newStatus, waktuSelesaiPengerjaan: newStatus.timestamp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Selesaikan Pengerjaan",
          fillParent: true,
          onPressed: () => _selesaikanPengerjaan(context),
        ),
      ],
    );
  }
}
