part of '../customer_servis_form_screen.dart';

class _Form extends StatelessWidget {
  final BengkelProfile profile;
  const _Form({required this.profile});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    final cubit = context.read<CustomerServisFormCubit>();
    return Form(
      key: cubit.form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Formulir pemesanan servis",
            style: text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600, color: color.onBackground),
          ),
          Divider(
            color: color.outline,
          ),
          20.verticalSpace,
          SGTextField(
            validator: ValueValidatorBuilder.create("Nama motor")
                .notNull()
                .notEmpty()
                .build,
            controller: cubit.namaMotor,
            label: "Nama Motor",
          ),
          24.verticalSpace,
          SGTextField(
            controller: cubit.platNomor,
            validator: ValueValidatorBuilder.create<String?>("Plat Nomor")
                .notNull()
                .notEmpty()
                .custom((value) {
              final isPlatNomor = IndonesianMotorPlateNumberUtil.check(value!);
              return isPlatNomor ? null : "Plat Nomor tidak valid";
            }).build,
            label: "Plat Nomor",
          ),
          24.verticalSpace,
          SGMultiSelectField(
              controller: cubit.layanan,
              validator: ValueValidatorBuilder.create("Jenis Layanan")
                  .notEmpty()
                  .build,
              desc:
                  "*Bila service yang anda inginkan tidak ada, silahkan masukan pada bagian catatan",
              height: 100,
              label: "Servis yang dilakukan",
              items: profile.jenisLayanan
                  .map((e) => SGMultiSelectItem(e.name, e))
                  .toList()),
          24.verticalSpace,
          SGDateTimeField(
            controller: cubit.tanggal,
            validator: ValueValidatorBuilder.create("Tanngal Servis")
                .notNull()
                .notEmpty()
                .build,
            minimumDate: DateTime.now(),
            label: "Tanggal Servis",
          ),
          24.verticalSpace,
          SGTextField(
            controller: cubit.catatan,
            label: "Catatan",
            minLine: 5,
            maxLine: 10,
            desc:
                "*Tuliskan catatan, hal-hal yang ingin anda sampaikan seperti keluhan motor dll.",
          ),
          const SGHideWidget(child: _Button())
        ],
      ),
    );
  }
}
