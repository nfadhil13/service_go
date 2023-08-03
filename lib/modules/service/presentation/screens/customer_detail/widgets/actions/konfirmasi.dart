part of '../../servis_customer_detail_screen.dart';

class _ActionKonfirmasi extends StatelessWidget {
  final ServisStatusUnitKonfirmasiServis data;
  const _ActionKonfirmasi({super.key, required this.data});

  void _acceptServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final isAccepted = await SGConfirmationDialog.launchAsync(context,
        maxHeightPercentage: .8,
        title: "Terima Servis",
        desc: "Silahkan lihat detail perbaikan sebelum menerima servis ini",
        extraInfo: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: _KonfirmasiInfo(data: data),
        ));
    if (!isAccepted) return;
    cubit.updateServis(
      onErrorText: "Menerima servis error, silahkan coba lagi",
      onSuccessText: "Berhasil menerima servis",
      currentServisUpdater: (currentServis) =>
          currentServis.copyWith(statusData: ServisStatusMenungguPengerjaan()),
    );
  }

  void _totakServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final alasanPenolakan = await showDialog(
        context: context,
        builder: (context) => _PenoalakanServisDialog(
              data: data,
            ));
    if (alasanPenolakan is! String) return;
    cubit.updateServis(
      onErrorText: "Menolak servis error, silahkan coba lagi",
      onSuccessText: "Berhasil menolak servis",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: ServisStatusDibatalkan(
              alasan: alasanPenolakan,
              isDibatalkanBengkel: false,
              isDikembalikan: false)),
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

class _KonfirmasiInfo extends StatelessWidget {
  final ServisStatusUnitKonfirmasiServis data;
  const _KonfirmasiInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return SGExpandableContainer(
      bakcgorundColor: Colors.transparent,
      color: context.color.onSurface,
      title: "DetaiL Pengajuan Servis",
      child: Column(
        children: [
          14.verticalSpace,
          SGMultiImageField(
            readOnly: true,
            initialImages: data.attachments,
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
                data.deskripsiServis,
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

class _PenoalakanServisDialog extends StatefulWidget {
  final ServisStatusUnitKonfirmasiServis data;
  const _PenoalakanServisDialog({required this.data});

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
      maxHeightPercentage: .8,
      title: "Batalakna Perbaikan?",
      desc:
          "Silahkan lihat detail pengajuan servis terlebih dahulu. Bila anda yakin untuk membatalkan pesanan, silahkan isi alasan penolakan",
      confirmText: "Konfirmasi",
      cancelText: "Batal",
      onSubmit: _onAccept,
      action: Form(
        key: _form,
        child: Column(
          children: [
            14.verticalSpace,
            _KonfirmasiInfo(data: widget.data),
            14.verticalSpace,
            SGTextField(
              controller: _textEditingController,
              label: "Alasan Penolakan",
              minLine: 4,
              validator: ValueValidatorBuilder.create("Alasan Penolakan")
                  .notNull()
                  .minLengthOf(16,
                      errorText: "Alasan penolakan minimal 16 huruf")
                  .build,
              maxLine: 5,
            ),
          ],
        ),
      ),
    );
  }
}
