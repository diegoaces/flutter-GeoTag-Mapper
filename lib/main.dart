import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/data/repository/file_repository_impl.dart';
import 'package:flutter_geotag_mapper/domain/usecase/add_files_usecase.dart';
import 'package:flutter_geotag_mapper/domain/usecase/show_exif_data_usecase.dart';
import 'package:flutter_geotag_mapper/presentation/bloc/exif_bloc.dart';
import 'package:flutter_geotag_mapper/presentation/cubit/exif_cubit.dart';
import 'package:flutter_geotag_mapper/view/pages/home_page.dart';
import 'package:flutter_map/flutter_map.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    FileRepositoryImpl fileRepositoryImpl = FileRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExifBloc(AddFilesUseCase(fileRepositoryImpl)),
        ),
        BlocProvider(
          create: (context) => ExifCubit(
              showExifDataUseCase: ShowExifDataUseCase(fileRepositoryImpl)),
        ),
      ],
      child: const MaterialApp(
        title: 'Geotag Mapper',
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
