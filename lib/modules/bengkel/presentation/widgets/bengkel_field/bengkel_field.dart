import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:sizer/sizer.dart';

class BengkelField extends StatefulWidget {
  final BengkelProfile? initialBengkel;
  final String? label;
  final BengkelFieldController? controller;
  const BengkelField(
      {super.key, this.initialBengkel, this.controller, this.label});

  @override
  State<BengkelField> createState() => _BengkelFieldState();
}

class BengkelFieldController extends ValueNotifier<BengkelProfile?> {
  BengkelFieldController(BengkelProfile? initialValue) : super(initialValue);
}

class _BengkelFieldState extends State<BengkelField> {
  late final BengkelFieldController _controller;
  BengkelProfile? _profile;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller?.run((controller) {
          controller.value = widget.initialBengkel;
        }) ??
        BengkelFieldController(widget.initialBengkel);
    _profile = _controller.value;
    _controller.addListener(_valueChangeListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_valueChangeListener);
    widget.controller?.dispose();
    super.dispose();
  }

  void _valueChangeListener() {
    setState(() {
      _profile = _controller.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    final profile = _profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.label!,
              style: text.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(color: color.surface, boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 2.0,
              ),
            ]),
            width: double.infinity,
            child: profile != null
                ? _SelectedBengkel(profile: profile)
                : Container(
                    color: color.outlineVariant,
                    width: double.infinity,
                    height: 200,
                  )),
      ],
    );
  }
}

class _SelectedBengkel extends StatelessWidget {
  final BengkelProfile profile;
  const _SelectedBengkel({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        10.verticalSpace,
        InkWell(
          onTap: () async {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.navigation_rounded,
                color: color.primary,
              ),
              5.horizontalSpace,
              Text(
                "Arahkan ke bengkel",
                style: text.bodySmall?.copyWith(color: context.color.primary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
