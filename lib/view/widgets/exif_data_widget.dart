import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/presentation/cubit/exif_cubit.dart';

class ExifDataWidget extends StatelessWidget {
  const ExifDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ExifCubit, ExifCubitState>(
      builder: (context, state) {
        if (state is ExifCubitLoaded) {
          return Container(
            width: size.width * 0.5,
            height: size.height * 0.3,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: Column(
              children: [
                const Text(
                  'Exif Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Image.network(
                        state.imageExif.path,
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: const Text('Image Preview'),
                              ),
                              body: Center(
                                child: Image.network(
                                  state.imageExif.path,
                                  width: size.width,
                                  height: size.height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          state.imageExif.name,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          state.imageExif.point.latitude.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          state.imageExif.point.longitude.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container(
          width: size.width * 0.5,
          height: size.height * 0.3,
          padding: const EdgeInsets.all(10),
        );
      },
    );
  }
}
