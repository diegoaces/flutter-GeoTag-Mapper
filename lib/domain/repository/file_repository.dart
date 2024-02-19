import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_geotag_mapper/core/failures/failure.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';

abstract class FileRepository {
  Future<Either<Failure, List<ImageExif>>> getExifs(List<Uint8List?> path);
}
