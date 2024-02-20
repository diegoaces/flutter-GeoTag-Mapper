
import 'package:dartz/dartz.dart';
import 'package:flutter_geotag_mapper/core/failures/failure.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_data.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';

abstract class FileRepository {
  Future<Either<Failure, List<ImageExif>>> getExifs(
      List<ImageData> imageDataModels);
  Future<Either<Failure, ImageExif>> getExif(ImageExif imageExif);
}
