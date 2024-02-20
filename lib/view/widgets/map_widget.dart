import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/presentation/bloc/exif_bloc.dart';
import 'package:flutter_geotag_mapper/presentation/cubit/exif_cubit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MapController mapController = MapController();

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(
          41,
          71,
          116,
          0.58,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: size.height * 0.5,
      width: size.width * 0.49,
      child: BlocBuilder<ExifBloc, ExifState>(
        builder: (context, state) {
          if (state is ExifLoading) {
            return Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(202, 217, 242, 0.573),
                ),
                child: const Center(child: CircularProgressIndicator()));
          }
          if (state is ExifLoaded) {
            return FlutterMap(
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
                            child: GestureDetector(
                                child: const Icon(
                                  Icons.location_on,
                                  size: 30.0,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  mapController.move(e.point, 18.0);
                                  BlocProvider.of<ExifCubit>(context)
                                      .loadExifData(e);
                                })),
                      )
                      .toList(),
                ),
              ],
            );
          }
          return FlutterMap(
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
          );
        },
      ),
    );
  }
}
