part of '../bengkel_profile_form_screen.dart';

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
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
          ),
          3.h.verticalSpace,
          SGTextField(
            inputType: TextInputType.phone,
            label: "Nomor Telepon Bengkel",
          ),
          3.h.verticalSpace,
          SGTextField(
            label: "Alamat Bengkel",
            minLine: 3,
            maxLine: 3,
          ),
        ],
      ),
    )));
  }
}

class _ImagePicker extends StatelessWidget {
  const _ImagePicker({
    super.key,
  });

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
