import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class ImageExif extends Equatable {
  final String name;
  final String path;
  final LatLng point;

  const ImageExif(this.name, this.path, this.point);

  @override
  List<Object?> get props => [name, path];
}
