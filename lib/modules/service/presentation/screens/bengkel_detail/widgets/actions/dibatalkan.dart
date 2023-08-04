part of '../../servis_bengkel_detail_screen.dart';

class _ActionDibatalkan extends StatelessWidget {
  final ServisStatusDibatalkan statusData;
  const _ActionDibatalkan({super.key, required this.statusData});

  void _acceptServis(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final result = await showDialog(
      context: context,
      builder: (_) => _ActionPengambilanKetikaDibatalkan(statusData.alasan),
    );
    if (result is! DataPengambilanServis) return;
    cubit.updateServis(
      onErrorText: "Pengembalian servis error, silahkan coba lagi",
      onSuccessText: "Berhasil",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: statusData.copyWith(dataPengambilanServis: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Kembalikan Unit",
          fillParent: true,
          onPressed: () => _acceptServis(context),
        ),
      ],
    );
  }
}

class _ActionPengambilanKetikaDibatalkan extends StatefulWidget {
  final String alasan;
  const _ActionPengambilanKetikaDibatalkan(this.alasan);

  @override
  State<_ActionPengambilanKetikaDibatalkan> createState() =>
      _ActionPengambilanKetikaDibatalkanState();
}

class _ActionPengambilanKetikaDibatalkanState
    extends State<_ActionPengambilanKetikaDibatalkan> {
  final GlobalKey<FormState> _form = GlobalKey();
  final SGMultiImageFieldController _imageFieldController =
      SGMultiImageFieldController();
  final TextEditingController _picBengkel = TextEditingController();
  final TextEditingController _namaPenerima = TextEditingController();

  @override
  void dispose() {
    _imageFieldController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _form.currentState?.validate();
    if (isValid != true) return;
    context.router.root.pop(DataPengambilanServis(
        tanggalPengambilan: DateTime.now(),
        picBengkel: _picBengkel.text,
        catatan: widget.alasan,
        namaPengambil: _namaPenerima.text,
        bukti: _imageFieldController.value,
        isDibatalkan: true));
  }

  @override
  Widget build(BuildContext context) {
    return SGActionDialog(
        maxHeightPercentage: .9,
        onSubmit: _onSubmit,
        title: "Pengambilan Unit",
        desc: "Lengkapi data pengambilan unit yang dibatalkan",
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
                  label: "Alasan Pengembalian",
                  minLine: 4,
                  maxLine: 5,
                  readOnly: true,
                  initialValue: widget.alasan,
                  desc: "*Masukan alasan pengembalian",
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
