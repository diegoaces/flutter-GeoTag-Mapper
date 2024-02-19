import 'package:flutter/material.dart';
import 'package:flutter_geotag_mapper/view/widgets/dropzone_widget.dart';
import 'package:flutter_geotag_mapper/view/widgets/header_widget.dart';
import 'package:flutter_geotag_mapper/view/widgets/map_widget.dart';
import 'package:flutter_map/flutter_map.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.size,
    required this.mapController,
  });

  final Size size;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            HeaderWidget(size: size),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MapWidget(mapController: mapController),
            const DropZoneWidget(),
          ],
        ), 
      ],
    );
  }
}
