part of '../bengkel_list_screen.dart';

class _Map extends StatefulWidget {
  final List<BengkelProfileWithDistance> bengkelList;
  const _Map({super.key, required this.bengkelList});

  @override
  State<_Map> createState() => __MapState();
}

class __MapState extends State<_Map> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initialPositionMarker();
  }

  void _initialPositionMarker() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _markers = {
        Marker(
            markerId: const MarkerId("user-location"),
            position: context.currentLocation.latLgn
                .let((value) => LatLng(value.lat, value.long))),
        ...widget.bengkelList
            .map((e) => Marker(
                onTap: () {
                  context.read<BengkelListScreenCubit>().selectBengkel(e);
                },
                markerId: MarkerId(e.data.id),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan),
                position: e.data.lokasi
                    .let((value) => LatLng(value.lat, value.long))))
            .toSet()
      };
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BengkelListScreenCubit, BengkelListScreenCubitState>(
      listener: (context, state) {
        final selectedBengkel = state.selectedBengkel;
        if (selectedBengkel != null) {
          _controller.future.then((value) => value.animateCamera(
              CameraUpdate.newCameraPosition(
                  selectedBengkel.data.lokasi.cameraPostion)));
        }
      },
      child: GoogleMap(
          zoomControlsEnabled: false,
          markers: _markers,
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: context.currentLocation.latLgn.cameraPostion),
    );
  }
}
