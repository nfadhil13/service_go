part of '../../servis_bengkel_detail_screen.dart';

class _ActionTerimaUnit extends StatelessWidget {
  const _ActionTerimaUnit({super.key});

  void _terimaUnit(BuildContext context) async {
    final cubit = context.read<ServisDetailCubit>();
    final penerima = await showDialog(
        context: context, builder: (context) => const _PenerimaanUnitDialog());
    if (penerima is! String) return;
    cubit.updateServis(
      onErrorText: "Menerima unit error, silahkan coba lagi",
      onSuccessText: "Berhasil mengubah status unit jadi diterima",
      currentServisUpdater: (currentServis) => currentServis.copyWith(
          statusData: ServisStatusUnitDiterima(namaPenerima: penerima)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SGElevatedButton(
          label: "Terima Unit",
          fillParent: true,
          onPressed: () => _terimaUnit(context),
        ),
      ],
    );
  }
}

class _PenerimaanUnitDialog extends StatefulWidget {
  const _PenerimaanUnitDialog();

  @override
  State<_PenerimaanUnitDialog> createState() => _PenerimaanUnitDialogState();
}

class _PenerimaanUnitDialogState extends State<_PenerimaanUnitDialog> {
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
        onSubmit: _onAccept,
        maxHeightPercentage: .5,
        title: "Terima Unit?",
        desc: "Apakah anda yakin bawha unit pesanan telah diterima?",
        action: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Form(
            key: _form,
            child: SGTextField(
              controller: _textEditingController,
              label: "Nama Penerima Unit",
              validator: ValueValidatorBuilder.create("Nama Penerima Unit")
                  .notNull()
                  .notEmpty()
                  .build,
            ),
          ),
        ));
  }
}
