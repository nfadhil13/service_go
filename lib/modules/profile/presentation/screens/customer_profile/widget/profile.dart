part of '../customer_profile_screen.dart';

class _Profile extends StatelessWidget {
  final CustomerProfile profile;
  const _Profile({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Section(
          title: "Profil Pengguna",
          items: [
            ("Nama Lengkap", profile.nama),
            ("Nomor Telepon", profile.phoneNumber),
          ],
        ),
        if (context.userSession.userId == profile.id)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SGElevatedButton(
              fillParent: true,
              label: "Ubah Profil",
              onPressed: () {
                final profileCubit = context.read<CustomerProfileCubit>();
                final cubit = context.read<CustomerProfileScreenCubit>();
                context.router.push(CustomProfileFormRoute(
                    onCustomerProfileCreated: (customerProfile) async {
                  await context.router.pop();
                  profileCubit.setValue(customerProfile);
                  cubit.setCustomer(customerProfile);
                }));
              },
            ),
          )
      ],
    );
  }
}
