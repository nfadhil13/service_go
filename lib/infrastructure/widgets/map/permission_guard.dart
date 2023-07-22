part of 'map_picker.dart';

class SGLocationPermissionGuard extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  const SGLocationPermissionGuard({super.key, required this.builder});

  @override
  State<SGLocationPermissionGuard> createState() =>
      _SGLocationPermissionGuardState();
}

class _SGLocationPermissionGuardState extends State<SGLocationPermissionGuard> {
  bool? _isPermissionGranted;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    final status = await Permission.location.request();
    setState(() {
      _isPermissionGranted = status.isGranted;
    });
  }

  void _goToSettingPermission() async {
    final status = await Permission.location.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      _checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPermissionGranted = _isPermissionGranted;
    if (isPermissionGranted == null) return const SGLoadingOverlay();
    if (!isPermissionGranted) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              "Location permission needed please go to setting to change the permission or click this button"),
          SGElevatedButton(
              label: "Change location permission",
              onPressed: _goToSettingPermission)
        ],
      );
    }
    return widget.builder(context);
  }
}
