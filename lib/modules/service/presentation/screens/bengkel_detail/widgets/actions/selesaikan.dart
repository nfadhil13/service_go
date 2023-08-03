part of '../../servis_bengkel_detail_screen.dart';

class _ActionSelesaikan extends StatelessWidget {
  const _ActionSelesaikan({super.key});

  void _acceptServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final result = await showDialog(
      context: context,
      builder: (_) => const _SelesaikanServisDialog(),
    );
    if (result is! ServisStatusSelesai) return;
    cubit.updateServis(
      onErrorText: "Menyelesaikan servis error, silahkan coba lagi",
      onSuccessText: "Berhasil menyelesaikan servis",
      currentServisUpdater: (currentServis) =>
          currentServis.copyWith(statusData: result),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Selesaikan Servis",
          fillParent: true,
          onPressed: () => _acceptServis(context),
        ),
      ],
    );
  }
}

class _SelesaikanServisDialog extends StatefulWidget {
  const _SelesaikanServisDialog();

  @override
  State<_SelesaikanServisDialog> createState() =>
      _SelesaikanServisDialogState();
}

class _SelesaikanServisDialogState extends State<_SelesaikanServisDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  final SGMultiImageFieldController _imageFieldController =
      SGMultiImageFieldController();
  final TextEditingController _catatanPerbaikan = TextEditingController();
  final TextEditingController _picBengkel = TextEditingController();
  final TextEditingController _namaPenerima = TextEditingController();

  @override
  void dispose() {
    _catatanPerbaikan.dispose();
    _imageFieldController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _form.currentState?.validate();
    if (isValid != true) return;
    context.router.root.pop(ServisStatusSelesai(
        picBengkel: _picBengkel.text,
        namaPengambil: _namaPenerima.text,
        bukti: _imageFieldController.value,
        catatan: _catatanPerbaikan.text));
  }

  @override
  Widget build(BuildContext context) {
    return SGActionDialog(
        maxHeightPercentage: .9,
        onSubmit: _onSubmit,
        title: "Selesaikan Servis",
        desc: "Untuk menyelesaikan servis silahkan isi data dibawah",
        action: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Form(
            key: _form,
            child: Column(
              children: [
                SGTextField(
                  controller: _picBengkel,
                  label: "PIC Bengkel",
                  validator: ValueValidatorBuilder.create("PIC Bengkel")
                      .notNull()
                      .notEmpty()
                      .build,
                  desc: "*Masukan nama petugas bengkel yang mengembalikan unit",
                ),
                18.verticalSpace,
                SGTextField(
                  controller: _namaPenerima,
                  label: "Nama Penerima",
                  validator: ValueValidatorBuilder.create("Nama Penerima")
                      .notNull()
                      .notEmpty()
                      .build,
                  desc: "*Masukan nama pelanggan yang mengembalikan unit",
                ),
                18.verticalSpace,
                SGTextField(
                  controller: _catatanPerbaikan,
                  label: "Catatan Perbaikan",
                  minLine: 4,
                  maxLine: 5,
                  desc: "*Masukan catatan perbaikan sekiranya diperlukan",
                ),
                14.verticalSpace,
                SGMultiImageField(
                  controller: _imageFieldController,
                  label: "Bukti Pengembilan",
                  validator: ValueValidatorBuilder.create("Bukti Pengambilan")
                      .notEmpty()
                      .build,
                  desc:
                      "*Sertakan bukti pengambilan (Foto Pengambil, Nota dll)",
                ),
              ],
            ),
          ),
        ));
  }
}
