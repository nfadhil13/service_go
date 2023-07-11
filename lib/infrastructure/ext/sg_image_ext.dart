import 'dart:io';

import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/types/image.dart';

extension SGImageExt on SGImage {
  ImageProvider get provider {
    switch (this) {
      case SGFileImage image:
        return FileImage(File(image.data));
      case SGNetworkImage image:
        return NetworkImage(image.data);
    }
  }
}
