import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:service_go/infrastructure/types/image.dart';

abstract class SGStorageHelper {
  Future<String> uploadImage(SGFileImage image);
}

@Injectable(as: SGStorageHelper)
class SGStorageHelperImpl implements SGStorageHelper {
  final FirebaseStorage _storage;

  static const imageRef = "images";
  SGStorageHelperImpl(this._storage);

  @override
  Future<String> uploadImage(SGFileImage image) async {
    final ext = extension(image.data);
    final filename = UniqueKey();
    final fileNameWithExt = "$filename$ext";
    final ref = _storage.ref("images/$fileNameWithExt");
    await ref.putFile(File(image.data));
    return ref.getDownloadURL();
  }
}
