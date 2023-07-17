part of '../bengkel_profile_form_screen.dart';

class _Form extends StatelessWidget {
  final List<JenisLayanan> jenisLayananList;
  final BengkelProfile? bengkelProfile;
  const _Form({super.key, required this.jenisLayananList, this.bengkelProfile});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BengkelProfileFormCubit>();
    return SingleChildScrollView(
        child: Form(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ImagePicker(),
          5.h.verticalSpace,
          SGTextField(
            label: "Nama Bengkel",
            controller: cubit.namaBengkel,
            initialValue: bengkelProfile?.nama,
          ),
          3.h.verticalSpace,
          SGTextField(
            inputType: TextInputType.phone,
            label: "Nomor Telepon Bengkel",
            controller: cubit.nomorTelepon,
            initialValue: bengkelProfile?.nomorTelepon,
          ),
          3.h.verticalSpace,
          SGMultiSelectField(
              label: "Layanan Bengkel",
              items: jenisLayananList
                  .map((e) => SGMultiSelectItem(e.name, e))
                  .toList()),
          3.h.verticalSpace,
          SGMapPickerField(
            controller: cubit.lokasiBengkel,
            label: "Lokasi Bengkel",
            initialValue: bengkelProfile?.let((value) => SGMapPickerResult(
                location: value.lokasi, address: value.alamant)),
          ),
        ],
      ),
    )));
  }
}

class _ImagePicker extends StatelessWidget {
  const _ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Foto Profil",
          style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        1.h.verticalSpace,
        Row(
          children: [
            SGImagePickerField(
              width: 25.w,
              height: 25.w,
            ),
            5.w.horizontalSpace,
            Expanded(
              child: Text(
                "Foto ini akan dilihat oleh konsumer. Gunakan foto yang menarik!",
                style: context.text.bodySmall
                    ?.copyWith(color: context.color.onBackground),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
