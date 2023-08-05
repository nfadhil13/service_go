part of '../bengkel_profile_screen.dart';

class _Profile extends StatelessWidget {
  final BengkelProfile profile;
  const _Profile({required this.profile});

  @override
  Widget build(BuildContext context) {
    final isUser = profile.id == context.userSession.userId;
    return Column(
      children: [
        _Section(
          title: "Profil Pengguna",
          actionName: isUser ? "Ganti Profile" : null,
          actionOnTap: isUser
              ? () {
                  final profileCubit = context.read<BengkelProfileCubit>();
                  final cubit = context.read<BengkelProfileScreenCubit>();
                  context.router.push(BengkelProfileFormRoute(
                      onBengkelProfileCreated: (bengkelProfile) async {
                    await context.router.pop();
                    profileCubit.setValue(bengkelProfile);
                    cubit.setBengkel(bengkelProfile);
                  }));
                }
              : null,
          items: [
            _SectionItem(title: "Nama Lengkap", item: profile.nama),
            _SectionItem(title: "Nomor Telepon", item: profile.nomorTelepon),
            _SectionItem(
                title: "Layanan Bengkel",
                widget: _JenisLayanan(profile: profile)),
            _SectionItem(
                title: "Alamat Bengkel",
                widget: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SGMapPickerField(
                    initialValue: SGLocation(profile.lokasi, profile.alamat),
                    readOnly: true,
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

class _JenisLayanan extends StatelessWidget {
  const _JenisLayanan({
    super.key,
    required this.profile,
  });

  final BengkelProfile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: context.color.outline),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
        height: 150,
        width: double.infinity,
        child: Wrap(runSpacing: 8, children: [
          ...profile.jenisLayanan.map((e) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: context.color.primary),
                  child: Text(
                    e.name,
                    style: context.text.labelSmall
                        ?.copyWith(color: context.color.onPrimary),
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
