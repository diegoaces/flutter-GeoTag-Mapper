import 'package:dartz/dartz.dart';
import 'package:flutter_geotag_mapper/domain/entity/image_exif.dart';
import 'package:flutter_geotag_mapper/domain/repository/file_repository.dart';
import 'package:flutter_geotag_mapper/domain/usecase/show_exif_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'show_exif_data_usecase_test.mocks.dart';

@GenerateMocks([FileRepository])
void main() {
  MockFileRepository mockExifRepository = MockFileRepository();
  ShowExifDataUseCase showExifDataUseCase =
      ShowExifDataUseCase(mockExifRepository);

  test('should return exif data when call usecase', () async {
    var tExifData = const ImageExif("", "", LatLng(0, 0));
    // arrange
    when(mockExifRepository.getExif(any))
        .thenAnswer((_) async => Right(tExifData));
    // act
    var result = await showExifDataUseCase(ImageExifParams(tExifData));
    // assert
    expect(result, Right(tExifData));
    verify(mockExifRepository.getExif(tExifData));
    verifyNoMoreInteractions(mockExifRepository);
  });
}
