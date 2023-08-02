import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:service_go/infrastructure/architecutre/cubits/messenger/messenger_cubit.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:url_launcher/url_launcher.dart';

class SGIntents {
  static Future<void> call(BuildContext context,
      {required String phoneNumber}) async {
    final messenger = context.messenger;
    String url = "tel:$phoneNumber";
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      messenger.showErrorSnackbar("Gagal melakukan telepon");
    }
  }

  static Future<void> navigateFromTo(
      {required SGLatLong start,
      required SGLatLong end,
      String? startTitle,
      String? endTitle}) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showDirections(
      destination: Coords(
        end.lat,
        end.long,
      ),
      originTitle: startTitle,
      origin: Coords(start.lat, start.long),
      destinationTitle: endTitle,
    );
  }

  static Future<void> openWhatssApp(BuildContext context,
      {required String phoneNumber, String text = ""}) async {
    var androidUrl = "whatsapp://send?phone=$phoneNumber&text=$text";
    var iosUrl = "https://wa.me/$phoneNumber?text=${Uri.parse(text)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      context.messenger.showErrorSnackbar("WhatsApp tidak ada");
    }
  }
}
