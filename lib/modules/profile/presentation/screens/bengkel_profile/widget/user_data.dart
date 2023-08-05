part of '../bengkel_profile_screen.dart';

class _UserData extends StatelessWidget {
  final UserData userData;
  const _UserData({required this.userData});

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: "Data User",
      items: [
        _SectionItem(title: "Email", item: userData.email),
        _SectionItem(title: "Username", item: userData.username),
        _SectionItem(
            title: "Tipe Akun",
            item: userData.isBengkel ? "Bengkel" : "Customer")
      ],
    );
  }
}
