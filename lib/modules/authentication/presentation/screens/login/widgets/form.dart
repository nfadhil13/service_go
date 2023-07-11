part of '../login_screen.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SGIcon(
                size: 30.w,
              ),
              6.h.verticalSpace,
              SGTextField(
                controller: cubit.email,
                validator: ValueValidatorBuilder.create("Email")
                    .notEmpty()
                    .notNull()
                    .custom((_) => cubit.formError("email"))
                    .build,
                label: "Email",
              ),
              3.h.verticalSpace,
              SGPasswordField(
                validator: ValueValidatorBuilder.create("Password")
                    .notNull()
                    .notEmpty()
                    .custom((_) => cubit.formError("password"))
                    .build,
                controller: cubit.password,
                label: "Password",
              ),
              6.h.verticalSpace,
              SGElevatedButton(
                label: "Masuk",
                fillParent: true,
                onPressed: () {
                  context.read<LoginCubit>().login();
                },
              ),
              1.5.h.verticalSpace,
              SGOutlinedButton(
                label: "Lupa Password",
                fillParent: true,
                onPressed: () {
                  context.read<LoginCubit>().login();
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
  const _NoAccountSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Belum punya akun?",
          style: context.text.bodyLarge?.copyWith(
              color: context.color.outline, fontWeight: FontWeight.normal),
        ),
        InkWell(
          onTap: () {
            context.router.replace(const RegisterRoute());
          },
          child: Text(
            "Daftar disini",
            style:
                context.text.labelLarge?.copyWith(color: context.color.primary),
          ),
        )
      ],
    );
  }
}
