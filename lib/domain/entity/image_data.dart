import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ImageData extends Equatable {
  final String name;
  final String path;
  final Uint8List image;

  const ImageData(this.name, this.path, this.image);

  @override
  List<Object?> get props => [name, path, image];
}
