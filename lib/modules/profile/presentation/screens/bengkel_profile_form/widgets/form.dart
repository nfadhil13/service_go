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
            key: cubit.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImagePicker(bengkelProfile),
                  5.h.verticalSpace,
                  SGTextField(
                    label: "Nama Bengkel",
                    validator: ValueValidatorBuilder.create("Nama Bengkel")
                        .notNull()
                        .notEmpty()
                        .build,
                    controller: cubit.namaBengkel,
                  ),
                  3.h.verticalSpace,
                  SGTextField(
                    inputType: TextInputType.phone,
                    validator: ValueValidatorBuilder.create("Nomor Telepon")
                        .notNull()
                        .notEmpty()
                        .build,
                    label: "Nomor Telepon Bengkel",
                    controller: cubit.nomorTelepon,
                  ),
                  3.h.verticalSpace,
                  SGMultiSelectField<JenisLayanan>(
                      controller: cubit.jenisLayanan,
                      label: "Layanan Bengkel",
                      hintText: "Pilih Layanan bengkel",
                      initialValues: bengkelProfile?.jenisLayanan
                              .map((e) => SGMultiSelectItem(e.name, e))
                              .toList() ??
                          [],
                      validator: ValueValidatorBuilder.create("Layanan Bengkel")
                          .notNull()
                          .notEmpty()
                          .build,
                      items: jenisLayananList
                          .map((e) => SGMultiSelectItem(e.name, e))
                          .toList()),
                  3.h.verticalSpace,
                  SGMapPickerField(
                    validator: ValueValidatorBuilder.create("Lokasi Bengkel")
                        .notNull(
                          error: (fieldname) => "$fieldname harus diisi",
                        )
                        .build,
                    controller: cubit.lokasiBengkel,
                    label: "Lokasi Bengkel",
                    initialValue: bengkelProfile?.let(
                        (value) => SGLocation(value.lokasi, value.alamat)),
                  ),
                  5.h.verticalSpace,
                  SGElevatedButton(
                    label: "Submit",
                    fillParent: true,
                    onPressed: cubit.submit,
                  )
                ],
              ),
            )));
  }
}

class _ImagePicker extends StatelessWidget {
  final BengkelProfile? bengkelProfile;
  const _ImagePicker(this.bengkelProfile);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BengkelProfileFormCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Foto Profil",
          style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        1.h.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SGImagePickerField(
                initialImage: bengkelProfile?.profile,
                validator: ValueValidatorBuilder.create("Foto Bengkel")
                    .custom((value) {
                      return null;
                    })
                    .notNull()
                    .build,
                controller: cubit.profilePict,
                width: 25.w,
                height: 25.w,
              ),
            ),
            5.w.horizontalSpace,
            Expanded(
              flex: 2,
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
