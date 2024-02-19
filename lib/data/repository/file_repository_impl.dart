import 'dart:typed_data';
import 'package:latlong2/latlong.dart';

import 'package:dartz/dartz.dart';
import 'package:exif/exif.dart';
import 'package:flutter_geotag_mapper/core/failures/failure.dart';
import 'package:flutter_geotag_mapper/data/models/image_exif_model.dart';
import 'package:flutter_geotag_mapper/domain/repository/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  @override
  Future<Either<Failure, List<ImageExifModel>>> getExifs(
      List<Uint8List?> path) async {
    try {
      final List<ImageExifModel> files = [];

      for (var file in path) {
        Map<String, IfdTag> imageExif = await readExifFromBytes(file!);
        files.add(ImageExifModel(
            "file.name", "file.path", exifGPSToLatLng(imageExif)));
      }
      return Right(files);
    } catch (e) {
      return Left(ReadExifFailure());
    }
  }

  exifGPSToLatLng(Map<String, IfdTag> tags) {
    final latitudeValue = tags['GPS GPSLatitude']
            ?.values
            .toList()
            .map<double>((item) =>
                (item.numerator.toDouble() / item.denominator.toDouble()))
            .toList() ??
        [];
    final latitudeSignal = tags['GPS GPSLatitudeRef']?.printable;

    final longitudeValue = tags['GPS GPSLongitude']
            ?.values
            .toList()
            .map<double>((item) =>
                (item.numerator.toDouble() / item.denominator.toDouble()))
            .toList() ??
        [];

    final longitudeSignal = tags['GPS GPSLongitudeRef']?.printable;

    double latitude =
        latitudeValue[0] + (latitudeValue[1] / 60) + (latitudeValue[2] / 3600);

    double longitude = longitudeValue[0] +
        (longitudeValue[1] / 60) +
        (longitudeValue[2] / 3600);

    if (latitudeSignal == 'S') latitude = -latitude;
    if (longitudeSignal == 'W') longitude = -longitude;

    return LatLng(latitude, longitude);
  }
}
