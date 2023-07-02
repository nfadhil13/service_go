part of '../register_screen.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              14.verticalSpace,
              ServiceGoIcon(
                size: 30.w,
              ),
              6.h.verticalSpace,
              ServiceGoTextField(
                validator: ValueValidatorBuilder.create("Username")
                    .notNull()
                    .notEmpty()
                    .custom((_) => cubit.errors["username"])
                    .build,
                controller: cubit.username,
                label: "Username",
              ),
              3.h.verticalSpace,
              ServiceGoTextField(
                controller: cubit.email,
                validator: ValueValidatorBuilder.create("Email")
                    .email()
                    .custom((_) => cubit.errors["email"])
                    .build,
                label: "Email",
              ),
              3.h.verticalSpace,
              ServiceGoTextField(
                validator: ValueValidatorBuilder.create("Password")
                    .password()
                    .custom((_) => cubit.errors["password"])
                    .build,
                controller: cubit.password,
                label: "Password",
              ),
              3.h.verticalSpace,
              ServiceGoTextField(
                validator: ValueValidatorBuilder.create("Konfirmasi Password")
                    .custom((_) => cubit.errors["confirmPassword"])
                    .build,
                controller: cubit.confirmPassword,
                label: "Konfirmasi Password",
              ),
              6.h.verticalSpace,
              ServiceGoElevatedButton(
                label: "Daftar",
                fillParent: true,
                onPressed: () {
                  context.read<RegisterCubit>().register();
                },
              ),
              2.7.h.verticalSpace,
              const _NoAccountSection()
            ],
          ),
        ),
      ),
    );
  }
}

class _NoAccountSection extends StatelessWidget {
  const _NoAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sudah punya akun?",
          style: context.text.bodyLarge?.copyWith(
              color: context.color.outline, fontWeight: FontWeight.normal),
        ),
        InkWell(
          onTap: () {
            context.router.replace(const LoginRoute());
          },
          child: Text(
            "Masuk disini",
            style:
                context.text.labelLarge?.copyWith(color: context.color.primary),
          ),
        )
      ],
    );
  }
}
