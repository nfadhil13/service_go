part of '../customer_profile_form_screen.dart';

class _Form extends StatelessWidget {
  final CustomerProfile? profile;
  const _Form({this.profile});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerProfileFormCubit>();
    return SingleChildScrollView(
      child: Form(
        key: cubit.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SGTextField(
                label: "Nama Lengkap",
                validator: ValueValidatorBuilder.create("Nama Lengkap")
                    .notNull()
                    .notEmpty()
                    .build,
                controller: cubit.name,
              ),
              3.h.verticalSpace,
              SGTextField(
                label: "Nomor Telepon",
                validator: ValueValidatorBuilder.create("Nomor Telepon")
                    .notNull()
                    .notEmpty()
                    .build,
                controller: cubit.nomorTelepon,
              ),
              5.h.verticalSpace,
              SGElevatedButton(
                label: "Submit",
                fillParent: true,
                onPressed: cubit.submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
