part of 'exif_cubit.dart';

class ExifCubitState extends Equatable {
  const ExifCubitState();

  @override
  List<Object> get props => [];
}

class ExifCubitInitial extends ExifCubitState {}

class ExifCubitLoading extends ExifCubitState {}

class ExifCubitError extends ExifCubitState {
  final String message;

  const ExifCubitError(this.message);

  @override
  List<Object> get props => [message];
}

class ExifCubitLoaded extends ExifCubitState {
  final ImageExif imageExif;

  const ExifCubitLoaded(this.imageExif);

  @override
  List<Object> get props => [imageExif];
}
