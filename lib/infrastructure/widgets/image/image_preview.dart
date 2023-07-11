import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:service_go/infrastructure/types/image.dart';

class SGImagePreview extends StatelessWidget {
  final SGImage image;
  const SGImagePreview({super.key, required this.image});

  static Future<void> asFullScreenDialog(BuildContext context, SGImage image) {
    return showDialog(
      context: context,
      builder: (_) => SGImagePreview(image: image),
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: image.provider,
          backgroundDecoration:
              BoxDecoration(color: Colors.black.withOpacity(.5)),
        ),
      ],
    );
  }
}
