import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class SGImage<T> extends Equatable {
  final T data;
  final String _type;

  static SGImage fromJSON(Map<String, dynamic> json) {
    final type = json["type"];
    switch (type) {
      case SGNetworkImage.type:
        return SGNetworkImage(json["data"]);
      case SGFileImage.type:
        return SGFileImage(json["data"]);
    }
    throw Exception("Uknown Image");
  }

  ImageProvider get provider {
    switch (this) {
      case SGFileImage image:
        return FileImage(File(image.data));
      case SGNetworkImage image:
        return NetworkImage(image.data);
    }
  }

  const SGImage(this.data, {required String type}) : _type = type;

  bool get isLocal;

  Map<String, dynamic> toJSON() => {"type": _type, "data": dataToJSON()};

  dynamic dataToJSON();
}

class SGNetworkImage extends SGImage<String> {
  static const String type = "network";

  const SGNetworkImage(super.data) : super(type: type);

  @override
  bool get isLocal => false;

  @override
  dataToJSON() => data;

  @override
  List<Object?> get props => [data];
}

class SGFileImage extends SGImage<String> {
  static const String type = "file";

  const SGFileImage(super.data) : super(type: type);

  @override
  bool get isLocal => true;

  @override
  dataToJSON() => data;

  @override
  List<Object?> get props => [data];
}
