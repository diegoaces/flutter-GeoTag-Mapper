part of 'exif_bloc.dart';

class ExifEvent extends Equatable {
  const ExifEvent();

  @override
  List<Object> get props => [];
}

class ExifLoadFilesEvent extends ExifEvent {
  final List<ImageDataModel> files;

  const ExifLoadFilesEvent(this.files);

  @override
  List<Object> get props => [files];
}
