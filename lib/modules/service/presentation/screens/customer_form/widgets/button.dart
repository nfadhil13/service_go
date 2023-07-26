part of '../customer_servis_form_screen.dart';

class _Button extends StatelessWidget {
  const _Button({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerServisFormCubit>();
    return Container(
      decoration: BoxDecoration(color: context.color.surface, boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 6.0,
        ),
      ]),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: SGElevatedButton(
        label: "Pesan",
        onPressed: () => cubit.submit(context.userSession.userId),
        fillParent: true,
      ),
    );
  }
}
