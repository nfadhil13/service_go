part of '../customer_profile_screen.dart';

class _UserData extends StatelessWidget {
  final UserData userData;
  const _UserData({required this.userData});

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: "Data User",
      items: [
        ("Email", userData.email),
        ("Username", userData.username),
        ("Tipe Akun", userData.isBengkel ? "Bengkel" : "Customer")
      ],
    );
  }
}
