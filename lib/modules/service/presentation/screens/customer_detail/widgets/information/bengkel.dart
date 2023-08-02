part of '../../servis_customer_detail_screen.dart';

class _Bengkel extends StatefulWidget {
  final BengkelProfile bengkelProfile;
  final EdgeInsets? padding;
  const _Bengkel({super.key, required this.bengkelProfile, this.padding});

  @override
  State<_Bengkel> createState() => _BengkelState();
}

class _BengkelState extends State<_Bengkel> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color.primary;
    final bengkel = widget.bengkelProfile;
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() {
              _isOpen = !_isOpen;
            }),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Data Bengkel",
                    style: context.text.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(_isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up)
              ],
            ),
          ),
          if (_isOpen) 12.verticalSpace,
          if (_isOpen)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => SGImagePreview.asFullScreenDialog(
                      context, bengkel.profile),
                  child: Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: bengkel.profile.provider)),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Bengkel",
                        style: text.bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      bengkel.nama,
                      style: text.bodySmall,
                    ),
                    12.verticalSpace,
                    Text("Alamat",
                        style: text.bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      "${bengkel.alamat.shortAddress}, ${bengkel.alamat.subAdministrativeArea}",
                      style: text.bodySmall,
                    ),
                    12.verticalSpace,
                  ],
                )),
              ],
            ),
          if (_isOpen) 14.verticalSpace,
          if (_isOpen)
            _BengkelActions(
                bengkel: bengkel, bengkelProfile: widget.bengkelProfile)
        ],
      ),
    );
  }
}

class _BengkelActions extends StatelessWidget {
  const _BengkelActions({
    super.key,
    required this.bengkel,
    required this.bengkelProfile,
  });

  final BengkelProfile bengkel;
  final BengkelProfile bengkelProfile;

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
                phoneNumber: bengkelProfile.nomorTelepon,
                text: "Halo saya ingin bertanya"),
            text: "Whatsapp",
            icon: Icons.call,
            color: Colors.green),
        14.horizontalSpace,
        _ActionIcon(
            onTap: () => SGIntents.call(
                  context,
                  phoneNumber: bengkelProfile.nomorTelepon,
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
