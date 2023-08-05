part of '../bengkel_profile_screen.dart';

class _BengkelActions extends StatelessWidget {
  const _BengkelActions({
    super.key,
    required this.bengkel,
  });

  final BengkelProfile bengkel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionIcon(
            onTap: () => SGIntents.navigateFromTo(
                start: context.currentLocation.latLgn,
                end: bengkel.lokasi,
                endTitle: bengkel.nama,
                startTitle: context.currentLocation.shortAddress),
            text: "Rute",
            icon: Icons.navigation_rounded),
        14.horizontalSpace,
        _ActionIcon(
            onTap: () => SGIntents.openWhatssApp(context,
                phoneNumber: bengkel.nomorTelepon,
                text: "Halo saya ingin bertanya"),
            text: "Whatsapp",
            icon: Icons.call,
            color: Colors.green),
        14.horizontalSpace,
        _ActionIcon(
            onTap: () => SGIntents.call(
                  context,
                  phoneNumber: bengkel.nomorTelepon,
                ),
            text: "Telepon",
            icon: Icons.phone_enabled,
            color: context.color.primary),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? color;
  final IconData icon;
  const _ActionIcon(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.text;
    final color = this.color ?? context.color.primary;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: color)),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          5.verticalSpace,
          Text(
            text,
            style: textTheme.bodySmall
                ?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
