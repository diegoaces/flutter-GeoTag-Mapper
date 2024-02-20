import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geotag_mapper/core/failures/failure.dart';
import 'package:flutter_geotag_mapper/core/usecases/usecase.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';
import 'package:flutter_geotag_mapper/domain/repository/file_repository.dart';

class ShowExifDataUseCase extends UseCase<ImageExif, ImageExifParams> {
  final FileRepository repository;

  ShowExifDataUseCase(this.repository);

  @override
  Future<Either<Failure, ImageExif>> call(ImageExifParams params) async {
    return await repository.getExif(params.imageExif);
  }
}

class ImageExifParams extends Equatable {
  final ImageExif imageExif;

  const ImageExifParams(this.imageExif);

  @override
  List<Object?> get props => [imageExif];
}
