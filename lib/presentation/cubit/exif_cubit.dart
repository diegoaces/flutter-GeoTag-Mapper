import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';
import 'package:flutter_geotag_mapper/domain/usecase/show_exif_data_usecase.dart';

part 'exif_state.dart';

class ExifCubit extends Cubit<ExifCubitState> {
  ShowExifDataUseCase showExifDataUseCase;

  ExifCubit({required this.showExifDataUseCase}) : super(ExifCubitInitial());

  Future<void> loadExifData(ImageExif imageExif) async {
    emit(ExifCubitLoading());
    var result = await showExifDataUseCase(ImageExifParams(imageExif));

    result.fold(
      (failure) => emit(const ExifCubitError('Error loading files')),
      (success) => emit(ExifCubitLoaded(success)),
    );
  }
}
