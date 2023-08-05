part of '../bengkel_profile_screen.dart';

class _JadwalBengkel extends StatelessWidget {
  final BengkelProfile profile;
  final JadwalBengkel jadwalBengkel;
  const _JadwalBengkel(
      {super.key, required this.jadwalBengkel, required this.profile});

  String getWeekdayName(int weekday) {
    final DateTime now = DateTime.now().toLocal();
    final int diff = now.weekday - weekday; // weekday is our 1-7 ISO value
    DateTime udpatedDt;
    if (diff > 0) {
      udpatedDt = now.subtract(Duration(days: diff));
    } else if (diff == 0) {
      udpatedDt = now;
    } else {
      udpatedDt = now.add(Duration(days: diff * -1));
    }
    final String weekdayName = DateFormat('EEEE', 'id_ID').format(udpatedDt);
    return weekdayName;
  }

  String _buildItem(
      JadwalBengkelItem? jadwalBengkelItem, BuildContext context) {
    if (jadwalBengkelItem == null) return "Tutup";
    final (buka, tutup) = jadwalBengkelItem;
    return "${buka.format(context)} - ${tutup.format(context)}";
  }

  @override
  Widget build(BuildContext context) {
    final isUser = profile.id == context.userSession.userId;
    return _Section(
        title: "Jadwal Bengkel",
        actionName: isUser ? "Ubah Jadwal" : null,
        actionOnTap: isUser
            ? () async {
                final cubit = context.read<BengkelProfileScreenCubit>();
                final result =
                    await context.router.push(const JadwalBengkelFormRoute());
                if (result != true) return;
                cubit.getBengkelProfile(profile.id);
              }
            : null,
        items: jadwalBengkel.asList.entries
            .map((entry) => _SectionItem(
                title: getWeekdayName(entry.key),
                item: _buildItem(entry.value, context)))
            .toList());
  }
}
