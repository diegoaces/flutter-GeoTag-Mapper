import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/data/repository/file_repository_impl.dart';
import 'package:flutter_geotag_mapper/domain/usecase/add_files_usecase.dart';
import 'package:flutter_geotag_mapper/presentation/bloc/exif_bloc.dart';
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
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          ExifBloc(AddFilesUseCase(fileRepository: FileRepositoryImpl())),
      child: MaterialApp(
        title: 'Geotag Mapper',
        home: Scaffold(
          body: HomePage(size: size, mapController: mapController),
        ),
      ),
    );
  }
}
