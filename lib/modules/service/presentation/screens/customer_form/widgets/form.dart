part of '../customer_servis_form_screen.dart';

class _Form extends StatelessWidget {
  final BengkelProfile profile;
  const _Form({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Formulir pemesanan servis",
          style: text.bodySmall?.copyWith(
              fontWeight: FontWeight.w600, color: color.onBackground),
        ),
        Divider(
          color: color.outline,
        ),
        20.verticalSpace,
        SGTextField(
          label: "Nama Motor",
        ),
        24.verticalSpace,
        SGTextField(
          label: "Plat Nomor",
        ),
        24.verticalSpace,
        SGMultiSelectField(
            height: 100,
            label: "Servis yang dilakukan",
            items: profile.jenisLayanan
                .map((e) => SGMultiSelectItem(e.name, e))
                .toList()),
        24.verticalSpace,
        SGDateTimeField(
          minimumDate: DateTime.now(),
          label: "Tanggal Servis",
        ),
        const SGHideWidget(child: _Button())
      ],
    );
  }
}
