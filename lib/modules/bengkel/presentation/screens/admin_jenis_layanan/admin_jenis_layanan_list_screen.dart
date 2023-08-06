import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/utils/value_validator/form_validator.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/bengkel/domain/model/jenis_layanan.dart';
import 'package:service_go/modules/bengkel/presentation/screens/admin_jenis_layanan/cubit/admin_jenis_layanan_cubit.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class AdminJenisLayananListScreen extends StatelessWidget {
  const AdminJenisLayananListScreen({super.key});

  void _newOrUpdate(BuildContext context, {JenisLayanan? jenisLayanan}) async {
    final cubit = context.read<AdminJenisLayananCubit>();
    final namaLayanan = await showDialog(
        context: context,
        builder: (context) => _JenisLayananDialog(
              jenisLayanan: jenisLayanan,
            ));
    if (namaLayanan is! String) return;
    // print(namaLayanan);
    cubit.createOrUpdateJenisLayanan(
        namaLayanan: namaLayanan, id: jenisLayanan?.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AdminJenisLayananCubit>()..loadAllJenisLayanan(),
      child: Scaffold(
        appBar: const SGAppBar(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () => _newOrUpdate(context),
            backgroundColor: context.color.primary,
            child: const Icon(Icons.add),
          );
        }),
        body: BlocBuilder<AdminJenisLayananCubit, AdminJenisLayananState>(
          builder: (context, state) => switch (state) {
            AdminJenisLayananError() => Center(
                child: SGError(message: state.message),
              ),
            AdminJenisLayananLoadded() => _JenisLayanan(
                onTap: (jenisLayanan) =>
                    _newOrUpdate(context, jenisLayanan: jenisLayanan),
                jenisLayanan: state.jenisLayananList,
                isLoading: state is AdminJenisLayananLoaddedUploading,
              ),
            AdminJenisLayananLoading() => const SGLoadingOverlay()
          },
        ),
      ),
    );
  }
}

class _JenisLayanan extends StatelessWidget {
  final List<JenisLayanan> jenisLayanan;
  final void Function(JenisLayanan jenisLayanan) onTap;
  final bool isLoading;
  const _JenisLayanan(
      {required this.jenisLayanan,
      required this.isLoading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daftar Jenis Layanan",
                  style: context.text.titleLarge,
                ),
                2.h.verticalSpace,
                Wrap(runSpacing: 8, children: [
                  ...jenisLayanan.map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => onTap(e),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: context.color.primary),
                            child: Text(
                              e.name,
                              style: context.text.labelSmall
                                  ?.copyWith(color: context.color.onPrimary),
                            ),
                          ),
                        ),
                      )),
                ]),
              ],
            ),
          ),
        ),
        if (isLoading) const SGLoadingOverlay()
      ],
    );
  }
}

class _JenisLayananDialog extends StatefulWidget {
  final JenisLayanan? jenisLayanan;
  const _JenisLayananDialog({this.jenisLayanan});

  @override
  State<_JenisLayananDialog> createState() => _JenisLayananDialogState();
}

class _JenisLayananDialogState extends State<_JenisLayananDialog> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.jenisLayanan?.name ?? "";
  }

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
    final isUpdate = widget.jenisLayanan != null;
    return SGActionDialog(
      maxHeightPercentage: .8,
      title: isUpdate ? "Perbarui Jenis Layanan" : "Buat Jenis Layanan Baru",
      confirmText: "Buat",
      cancelText: "Batal",
      onSubmit: _onAccept,
      action: Form(
        key: _form,
        child: Column(
          children: [
            14.verticalSpace,
            SGTextField(
              controller: _textEditingController,
              label: "Jenis Layanan",
              validator: ValueValidatorBuilder.create("Jenis Layanan")
                  .notNull()
                  .minLengthOf(5, errorText: "Jenis Layanan minimal 5 huruf")
                  .build,
            ),
          ],
        ),
      ),
    );
  }
}
