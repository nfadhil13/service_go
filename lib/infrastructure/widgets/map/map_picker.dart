import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice_ex/places.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_go/infrastructure/env/network_constants.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/ext/placemark_ext.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/layouts/bottomsheet/bottom_sheet_container.dart';
import 'package:service_go/infrastructure/widgets/loading/circular.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:sizer/sizer.dart';

part 'permission_guard.dart';
part 'search_location.dart';

class SGMapPicker extends StatefulWidget {
  final String? title;
  final SGLocation? initialValue;
  const SGMapPicker({super.key, required this.title, this.initialValue});

  static Future<SGLocation?> pickLocation(BuildContext context,
      {String? title, SGLocation? initialValue}) async {
    final result = await context.router.pushNativeRoute(MaterialPageRoute(
      builder: (context) {
        return SGMapPicker(title: title, initialValue: initialValue);
      },
    ));
    if (result is SGLocation) return result;
    return null;
  }

  @override
  State<SGMapPicker> createState() => _SGMapPickerState();
}

class _SGMapPickerState extends State<SGMapPicker> {
  static const CameraPosition _defaultCameraPosition = CameraPosition(
      target: LatLng(-6.2, 106.816666), zoom: 19.151926040649414);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final ValueNotifier<bool> _isMoving = ValueNotifier(false);

  final ValueNotifier<({SGLatLong location, Placemark placemark})?> _location =
      ValueNotifier(null);

  late CameraPosition _cameraPosition;

  void _getCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _animateToLocation(
        SGLatLong(lat: location.latitude, long: location.longitude));
  }

  void _animateToLocation(SGLatLong location) async {
    final controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(location.lat, location.long),
            zoom: 19.151926040649414)));
    _getLocation();
  }

  void _onCameraIdle() async {
    _isMoving.value = false;
    _getLocation();
  }

  void _getLocation() async {
    final cameraPosition = _cameraPosition;
    final target = cameraPosition.target;
    final placeMark =
        await placemarkFromCoordinates(target.latitude, target.longitude);
    if (placeMark.isEmpty) return;
    _location.value = (
      placemark: placeMark[0],
      location: SGLatLong(lat: target.latitude, long: target.longitude)
    );
  }

  void _onCameraMoveStarted() {
    _isMoving.value = true;
    _location.value = null;
  }

  void _initLocation() {
    final initialLocation = widget.initialValue;
    if (initialLocation == null) {
      _cameraPosition = _defaultCameraPosition;
      _getCurrentLocation();
    } else {
      _cameraPosition = initialLocation.latLgn.let(
          (value) => CameraPosition(target: LatLng(value.lat, value.long)));
      _animateToLocation(initialLocation.latLgn);
    }
  }

  void _onAddressSelected(String address) async {
    _location.value = null;
    final location = await locationFromAddress(address);
    print("Location $location");
    if (location.isEmpty) return;

    _animateToLocation(location.first
        .let((value) => SGLatLong(lat: value.latitude, long: value.longitude)));
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _isMoving.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return Scaffold(
      body: SafeArea(
        child: SGLocationPermissionGuard(builder: (context) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 80.h,
                      child: Stack(
                        children: [
                          GoogleMap(
                              mapType: MapType.normal,
                              onCameraMoveStarted: _onCameraMoveStarted,
                              onCameraIdle: _onCameraIdle,
                              onCameraMove: (position) {
                                _cameraPosition = position;
                              },
                              onMapCreated: (controller) {
                                _controller.complete(controller);
                              },
                              compassEnabled: false,
                              zoomControlsEnabled: false,
                              initialCameraPosition: _cameraPosition),
                          Center(
                              child: ValueListenableBuilder(
                                  valueListenable: _isMoving,
                                  builder: (context, isMoving, _) {
                                    return Icon(
                                      Icons.location_on,
                                      color: color.primary,
                                      size: isMoving ? 9.w : 11.w,
                                    );
                                  })),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 33.h,
                        child: _Location(
                            onCurrentLocationTap: _getCurrentLocation,
                            title: widget.title ?? "Pilih Lokasi",
                            location: _location),
                      ),
                    ),
                    Positioned.fill(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: _SearchLocation(
                        onAddressSelected: _onAddressSelected,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _Location extends StatelessWidget {
  final String title;
  final VoidCallback onCurrentLocationTap;
  final ValueNotifier<({SGLatLong location, Placemark placemark})?> location;
  const _Location({
    super.key,
    required this.title,
    required this.location,
    required this.onCurrentLocationTap,
  });

  String locationString(Placemark placemark) {
    String address = '';
    if (placemark.name != null) {
      address += '${placemark.name}, ';
    }
    if (placemark.thoroughfare != null) {
      address += '${placemark.thoroughfare}, ';
    }
    if (placemark.subThoroughfare != null) {
      address += '${placemark.subThoroughfare}, ';
    }
    if (placemark.locality != null) {
      address += '${placemark.locality}, ';
    }
    if (placemark.administrativeArea != null) {
      address += '${placemark.administrativeArea}, ';
    }
    if (placemark.postalCode != null) {
      address += '${placemark.postalCode}, ';
    }
    if (placemark.country != null) {
      address += placemark.country!;
    }

    return address;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 3.w).copyWith(bottom: 2.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FloaingCircle(
                onTap: () {
                  context.router.pop();
                },
                icon: Icons.arrow_back,
              ),
              _FloaingCircle(
                icon: Icons.gps_fixed_outlined,
                onTap: onCurrentLocationTap,
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SGBottomSheetContainer(
                shadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                  child: ValueListenableBuilder(
                      valueListenable: location,
                      builder: (__, value, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: context.text.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                            .5.h.verticalSpace,
                            Expanded(
                              child: value == null
                                  ? const SGCircularLoading()
                                  : AutoSizeText(
                                      locationString(value.placemark),
                                    ),
                            ),
                            1.h.verticalSpace,
                            SGElevatedButton(
                              label: "Pilh Lokasi",
                              fillParent: true,
                              onPressed: value == null
                                  ? null
                                  : () {
                                      context.router.pop(SGLocation(
                                          SGLatLong(
                                              lat: value.location.lat,
                                              long: value.location.long),
                                          value.placemark.toSGPlaceMark()));
                                    },
                              padding: EdgeInsets.symmetric(vertical: 1.25.h),
                            )
                          ],
                        );
                      }),
                )),
          ),
        ),
      ],
    );
  }
}

class _FloaingCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _FloaingCircle({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        padding: EdgeInsets.all(1.5.w),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ]),
        child: Icon(icon),
      ),
    );
  }
}
