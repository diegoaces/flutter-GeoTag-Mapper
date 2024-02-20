import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_geotag_mapper/core/failures/failure.dart';
import 'package:flutter_geotag_mapper/core/usecases/usecase.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_data.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';
import 'package:flutter_geotag_mapper/domain/repository/file_repository.dart';

class AddFilesUseCase extends UseCase<void, AddFilesParams> {
  final FileRepository fileRepository;

  AddFilesUseCase(this.fileRepository);

  @override
  Future<Either<Failure, List<ImageExif>>> call(AddFilesParams params) async {
    return fileRepository.getExifs(params.files);
  }
}

class AddFilesParams extends Equatable {
  final List<ImageData> files;

  const AddFilesParams({required this.files});

  @override
  List<Object?> get props => [files];
}
