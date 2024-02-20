import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/data/models/image_data_model.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';
import 'package:flutter_geotag_mapper/domain/usecase/add_files_usecase.dart';

part 'exif_event.dart';
part 'exif_state.dart';

class ExifBloc extends Bloc<ExifEvent, ExifState> {
  AddFilesUseCase addFilesUseCase;

  ExifBloc(this.addFilesUseCase) : super(ExifInitial()) {
    on<ExifLoadFilesEvent>((event, emit) async {
      emit(ExifLoading());
      var result = await addFilesUseCase(AddFilesParams(files: event.files));
      await Future.delayed(const Duration(seconds: 1));

      result.fold(
        (failure) => emit(const ExifError('Error loading files')),
        (success) => emit(ExifLoaded(success)),
      );
    });
  }
}
