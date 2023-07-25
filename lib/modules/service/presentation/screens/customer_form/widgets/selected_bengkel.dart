part of '../customer_servis_form_screen.dart';

class _SelectedBengkel extends StatelessWidget {
  final BengkelProfile profile;
  const _SelectedBengkel({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bengkel Pilihan",
          style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        10.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () =>
                  SGImagePreview.asFullScreenDialog(context, profile.profile),
              child: Container(
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: profile.profile.provider)),
              ),
            ),
            16.horizontalSpace,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Bengkel",
                    style:
                        text.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  profile.nama,
                  style: text.bodySmall,
                ),
                12.verticalSpace,
                Text("Alamat",
                    style:
                        text.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  "${profile.alamat.shortAddress}, ${profile.alamat.subAdministrativeArea}",
                  style: text.bodySmall,
                ),
                12.verticalSpace,
              ],
            )),
          ],
        ),
        12.verticalSpace,
        Column(
          children: [
            _JadwalBengkel(
              jadwalBengkel: profile.jadwalBengkel,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "* Jadwal bengkel hanyalah jadwal rutin bengkel. Bengkel mungkin menerima pesanan diluar jadwal normal",
                style: text.bodySmall,
              ),
            )
          ],
        ),
        12.verticalSpace,
        SGOutlinedButton(
          buttonIconType: ButtonIconType.near,
          fillParent: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onPressed: () async {
            final currentLocation = context.currentLocation;
            final availableMaps = await MapLauncher.installedMaps;
            final location = profile.lokasi;
            await availableMaps.first.showDirections(
              destination: Coords(
                location.lat,
                location.long,
              ),
              originTitle: currentLocation.shortAddress,
              origin: currentLocation.latLgn
                  .let((value) => Coords(value.lat, value.long)),
              destinationTitle: profile.nama,
            );
          },
          label: "Arahkan ke bengkel",
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.navigation_rounded,
              color: color.primary,
            ),
          ),
          textStyle: text.bodySmall?.copyWith(color: context.color.primary),
        )
      ],
    );
  }
}

class _JadwalBengkel extends StatefulWidget {
  final JadwalBengkel jadwalBengkel;
  const _JadwalBengkel({super.key, required this.jadwalBengkel});

  @override
  State<_JadwalBengkel> createState() => __JadwalBengkelState();
}

class __JadwalBengkelState extends State<_JadwalBengkel> {
  bool _isShown = false;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final spacing = 6.verticalSpace;
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            _isShown = !_isShown;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jadwal Bengkel",
                    style: text.bodyMedium
                        ?.copyWith(color: context.color.onBackground),
                  ),
                  Icon(_isShown ? Icons.arrow_drop_down : Icons.arrow_drop_up)
                ],
              ),
              if (_isShown)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _JadwalItem(
                          title: "Senin", item: widget.jadwalBengkel.monday),
                      spacing,
                      _JadwalItem(
                          title: "Selasa", item: widget.jadwalBengkel.teusday),
                      spacing,
                      _JadwalItem(
                          title: "Rabu", item: widget.jadwalBengkel.wednesday),
                      spacing,
                      _JadwalItem(
                          title: "Kamis", item: widget.jadwalBengkel.thursday),
                      spacing,
                      _JadwalItem(
                          title: "Juma't", item: widget.jadwalBengkel.friday),
                      spacing,
                      _JadwalItem(
                          title: "Sabtu", item: widget.jadwalBengkel.saturday),
                      spacing,
                      _JadwalItem(
                          title: "Minggu", item: widget.jadwalBengkel.sunday),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _JadwalItem extends StatelessWidget {
  final String title;
  final JadwalBengkelItem? item;
  const _JadwalItem({super.key, required this.title, this.item});

  @override
  Widget build(BuildContext context) {
    final style =
        context.text.bodySmall?.copyWith(color: context.color.outline);
    final item = this.item;
    if (item == null) {
      return Text(
        "$title, Tutup",
        style: style,
      );
    }
    final (buka, tutup) = item;
    return Text(
      "$title, ${buka.format(context)} - ${tutup.format(context)}",
      style: style,
    );
  }
}
