import 'package:flutter/material.dart';
import 'package:flutter_geotag_mapper/view/widgets/dropzone_widget.dart';
import 'package:flutter_geotag_mapper/view/widgets/exif_data_widget.dart';
import 'package:flutter_geotag_mapper/view/widgets/header_widget.dart';
import 'package:flutter_geotag_mapper/view/widgets/map_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            HeaderWidget(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MapWidget(),
            DropZoneWidget(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 20), ExifDataWidget()],
        ),
      ],
    );
  }
}
