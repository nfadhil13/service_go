import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/map/map_picker.dart';
import 'package:sizer/sizer.dart';

class SGMapPickerField extends StatefulWidget {
  final double height;
  final String? label;
  final SGLocation? initialValue;
  final String? Function(SGLocation? result)? validator;
  final SGMapPickerFieldController? controller;
  final bool readOnly;
  const SGMapPickerField(
      {super.key,
      this.height = 240,
      this.label,
      this.initialValue,
      this.controller,
      this.readOnly = false,
      this.validator});

  @override
  State<SGMapPickerField> createState() => _SGMapPickerFieldState();
}

class SGMapPickerFieldController {
  _SGMapPickerFieldState? _state;

  void _init(_SGMapPickerFieldState? state) {
    _state = state;
  }

  void dispose() {
    _state = null;
  }

  SGLocation? get value => _state?._value;
}

class _SGMapPickerFieldState extends State<SGMapPickerField> {
  Radius get _borderRadius => const Radius.circular(8);

  SGLocation? _value;

  @override
  void initState() {
    super.initState();
    widget.controller?._init(this);
    _value = widget.initialValue;
  }

  void _changeLocation() async {
    final result =
        await SGMapPicker.pickLocation(context, initialValue: _value);
    if (result == null) return;
    setState(() {
      _value = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final value = _value;
    return FormField(
      validator: (_) => widget.validator?.call(value),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 1.5.h),
              child: Text(
                widget.label!,
                style: context.text.labelLarge,
              ),
            ),
          Container(
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: _borderRadius, topRight: _borderRadius)),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(child: _Map(location: _value?.latLgn)),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: color.background,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1), //(x,y)
                              blurRadius: 1.0,
                            ),
                          ]),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      height: widget.height * .25,
                      child: AutoSizeText(
                          _value?.addressString ?? "Anda belum memilih lokasi",
                          textAlign: TextAlign.start),
                    ),
                  ],
                ),
                if (value == null)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.3),
                        borderRadius: BorderRadius.only(
                            topLeft: _borderRadius, topRight: _borderRadius)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!widget.readOnly)
                          SGElevatedButton(
                            label: "Pilih Lokasi",
                            fillParent: false,
                            onPressed: _changeLocation,
                          ),
                      ],
                    ),
                  ),
                if (value != null && !widget.readOnly)
                  Positioned(
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SGElevatedButton(
                        label: "Ganti Lokasi",
                        fillParent: false,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        onPressed: _changeLocation,
                      ),
                    ),
                  )
              ],
            ),
          ),
          if (field.hasError)
            Text(
              field.errorText!,
              style:
                  context.text.bodySmall?.copyWith(color: context.color.error),
            )
        ],
      ),
    );
  }
}

class _Map extends StatefulWidget {
  final SGLatLong? location;
  const _Map({required this.location});

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  static const CameraPosition _defaultCameraPosition = CameraPosition(
      target: LatLng(-6.2, 106.816666), zoom: 19.151926040649414);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void _cameraToLocation(SGLatLong location) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.lat, location.long),
        zoom: 19.151926040649414)));
  }

  late final CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = widget.location.let((value) {
      if (value == null) return _defaultCameraPosition;
      return CameraPosition(
          target: LatLng(value.lat, value.long), zoom: 16.151926040649414);
    });
  }

  void _locationChange() {
    widget.location?.run((value) {
      _cameraToLocation(value);
    });
  }

  @override
  void didUpdateWidget(covariant _Map oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      _locationChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
            Center(
              child: Icon(
                Icons.location_on,
                color: context.color.primary,
                size: constraint.maxWidth * .1,
              ),
            )
          ],
        );
      }),
    );
  }
}
