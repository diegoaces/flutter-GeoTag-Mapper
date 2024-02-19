import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/presentation/bloc/exif_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.mapController,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ExifBloc, ExifState>(
      builder: (context, state) {
        if (state is ExifLoading) {
          return Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(
                  41,
                  71,
                  116,
                  0.58,
                ),
              ),
              height: size.height * 0.5,
              width: size.width * 0.49,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (state is ExifLoaded) {
          return SizedBox(
            height: size.height * 0.5,
            width: size.width * 0.49,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: state.files[0].point,
                initialZoom: 16.0,
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'cl.diegoacuna.exifreader',
                  tileProvider: CancellableNetworkTileProvider(),
                ),
                MarkerLayer(
                  markers: state.files
                      .map(
                        (e) => Marker(
                            width: 80.0,
                            height: 80.0,
                            point: e.point,
                            child: const Icon(Icons.location_on,
                                size: 30.0, color: Colors.red)),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        }
        return SizedBox(
          height: size.height * 0.5,
          width: size.width * 0.49,
          child: FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(-36.5, -72.09),
              initialZoom: 5.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'cl.diegoacuna.exifreader',
              ),
            ],
          ),
        );
      },
    );
  }
}
