part of '../bengkel_list_screen.dart';

class _Map extends StatefulWidget {
  const _Map({super.key});

  @override
  State<_Map> createState() => __MapState();
}

class __MapState extends State<_Map> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        markers: {
          Marker(
              markerId: MarkerId("location"),
              position: context.currentLocation.latLgn
                  .let((value) => LatLng(value.lat, value.long)))
        },
        initialCameraPosition: context.currentLocation.latLgn.cameraPostion);
  }
}
