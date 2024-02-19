part of 'exif_bloc.dart';

class ExifState extends Equatable {
  const ExifState();

  @override
  List<Object> get props => [];
}

class ExifInitial extends ExifState {}

class ExifLoading extends ExifState {}

class ExifLoaded extends ExifState {
  final List<ImageExif> files;

  const ExifLoaded(this.files);

  @override
  List<Object> get props => [files];
}

class ExifError extends ExifState {
  final String message;

  const ExifError(this.message);

  @override
  List<Object> get props => [message];
}
