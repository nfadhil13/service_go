part of '../../servis_bengkel_detail_screen.dart';

class _ActionPengajuanServis extends StatelessWidget {
  const _ActionPengajuanServis({super.key});

  void _acceptServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final result = await showDialog(
      context: context,
      builder: (_) => const _PengajuanServisDialog(),
    );
    if (result is! ServisStatusUnitKonfirmasiServis) return;
    cubit.updateServis(
      onErrorText: "Menerima servis error, silahkan coba lagi",
      onSuccessText: "Berhasil menerima servis",
      currentServisUpdater: (currentServis) =>
          currentServis.copyWith(statusData: result),
    );
  }

  void _totakServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final alasanPembatalan = await showDialog(
        context: context, builder: (_) => const _PembatalanServisDialog());
    if (alasanPembatalan is! String) return;
    cubit.updateServis(
      onErrorText: "Membatalkan servis error, silahkan coba lagi",
      onSuccessText: "Berhasil membatalkan servis",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: ServisStatusDibatalkan(
              alasan: alasanPembatalan,
              dataPengambilanServis: null,
              isDibatalkanBengkel: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Ajukan Servis",
          fillParent: true,
          onPressed: () => _acceptServis(context),
        ),
        12.verticalSpace,
        SGElevatedButton(
          label: "Tolak Servis",
          fillParent: true,
          backgroundColor: context.color.error,
          onPressed: () => _totakServis(context),
        ),
      ],
    );
  }
}

class _PengajuanServisDialog extends StatefulWidget {
  const _PengajuanServisDialog();

  @override
  State<_PengajuanServisDialog> createState() => _PengajuanServisDialogState();
}

class _PengajuanServisDialogState extends State<_PengajuanServisDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  final SGMultiImageFieldController _imageFieldController =
      SGMultiImageFieldController();
  final TextEditingController _detailPerbaikan = TextEditingController();

  @override
  void dispose() {
    _detailPerbaikan.dispose();
    _imageFieldController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _form.currentState?.validate();
    if (isValid != true) return;
    context.router.root.pop(ServisStatusUnitKonfirmasiServis(
        deskripsiServis: _detailPerbaikan.text,
        attachments: _imageFieldController.value));
  }

  @override
  Widget build(BuildContext context) {
    return SGActionDialog(
        maxHeightPercentage: .6,
        onSubmit: _onSubmit,
        title: "Ajukan Servis",
        desc:
            "Jelaskan servis yang akan dilakukan pada motor. Anda dapat menyertakan sparepart yang diganti, harga dll.",
        action: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Form(
            key: _form,
            child: Column(
              children: [
                SGMultiImageField(
                  controller: _imageFieldController,
                  label: "Gambar Pendukung",
                ),
                14.verticalSpace,
                SGTextField(
                  controller: _detailPerbaikan,
                  label: "Detail Perbaikan",
                  minLine: 4,
                  validator: ValueValidatorBuilder.create("Detail Perbaikan")
                      .notNull()
                      .notEmpty()
                      .build,
                  maxLine: 5,
                ),
              ],
            ),
          ),
        ));
  }
}

class _PembatalanServisDialog extends StatefulWidget {
  const _PembatalanServisDialog();

  @override
  State<_PembatalanServisDialog> createState() =>
      _PembatalanServisDialogState();
}

class _PembatalanServisDialogState extends State<_PembatalanServisDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _form.currentState?.validate();
    if (isValid != true) return;
    context.router.root.pop(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SGActionDialog(
        maxHeightPercentage: .6,
        onSubmit: _onSubmit,
        title: "Tolak Servis",
        desc:
            "Tolak servis yang diajukan. Penolakan servis dapat dikarenakan alesan tertentu seperti sparepart tidak tersedia. Jelaskan alasan penolakan pada isian dibawah",
        action: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Form(
            key: _form,
            child: SGTextField(
              controller: _textEditingController,
              label: "Alasan Pembatalan",
              minLine: 4,
              validator: ValueValidatorBuilder.create("Alasan Pembatalan")
                  .notNull()
                  .minLengthOf(16,
                      errorText: "Alasan penolakan minimal 16 huruf")
                  .build,
              maxLine: 5,
            ),
          ),
        ));
  }
}
