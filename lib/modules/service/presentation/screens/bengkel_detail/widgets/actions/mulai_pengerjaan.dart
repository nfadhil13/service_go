part of '../../servis_bengkel_detail_screen.dart';

class _ActionsMulaiPengerjaan extends StatelessWidget {
  const _ActionsMulaiPengerjaan();

  void _mulaiPengerjaan(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final isAccepted = await SGConfirmationDialog.launchAsync(context,
        title: "Mulai Pengerjaan?",
        desc: "Apakah anda yakin akan mulai pengerjaan servis unit ini?");
    if (!isAccepted) return;
    final newStatus = ServisStatusPengerjaanServis();
    cubit.updateServis(
      onErrorText: "Memulai pengerjaan error, silahkan coba lagi",
      onSuccessText: "Berhasil status unit menjadi sendang dikerjakan",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: newStatus, waktuMulaiPengerjaan: newStatus.timestamp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Mulai Pengerjaan",
          fillParent: true,
          onPressed: () => _mulaiPengerjaan(context),
        ),
      ],
    );
  }
}
