part of '../../servis_bengkel_detail_screen.dart';

class _ActionDiajukan extends StatelessWidget {
  const _ActionDiajukan({super.key});

  void _acceptServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final isAccepted = await SGConfirmationDialog.launchAsync(context,
        title: "Terima Servis", desc: "Anda yakin akan menerima servis ini ?");
    if (!isAccepted) return;
    cubit.updateServis(
      onErrorText: "Menerima servis error, silahkan coba lagi",
      onSuccessText: "Berhasil menerima servis",
      currentServisUpdater: (currentServis) =>
          currentServis.copyWith(statusData: ServisStatusPengajuanDiterima()),
    );
  }

  void _totakServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final alasanPenolakan = await showDialog(
        context: context,
        builder: (context) => const _PenoalakanServisDialog());
    if (alasanPenolakan is! String) return;
    cubit.updateServis(
      onErrorText: "Menolak servis error, silahkan coba lagi",
      onSuccessText: "Berhasil menolak servis",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: ServisStatusDitolak(alasanPenolakan: alasanPenolakan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Terima Servis",
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

class _PenoalakanServisDialog extends StatefulWidget {
  const _PenoalakanServisDialog({super.key});

  @override
  State<_PenoalakanServisDialog> createState() =>
      _PenoalakanServisDialogState();
}

class _PenoalakanServisDialogState extends State<_PenoalakanServisDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onAccept() {
    final isValid = _form.currentState?.validate();
    if (isValid != true) return;
    context.router.root.pop(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SGActionDialog(
      maxHeightPercentage: .6,
      title: "Tolak Pesanan?",
      desc:
          "Apakah anda yakin akan menolak pesanan ini?, Silahkan masukan alasan penolakan dibawah",
      confirmText: "Tolak",
      cancelText: "Batal",
      onSubmit: _onAccept,
      action: Form(
        key: _form,
        child: SGTextField(
          controller: _textEditingController,
          label: "Alasan Penolakan",
          minLine: 4,
          validator: ValueValidatorBuilder.create("Alasan Penolakan")
              .notNull()
              .minLengthOf(16, errorText: "Alasan penolakan minimal 16 huruf")
              .build,
          maxLine: 5,
        ),
      ),
    );
  }
}
