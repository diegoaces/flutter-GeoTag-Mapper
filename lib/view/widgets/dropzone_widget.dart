import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geotag_mapper/data/models/image_data_model.dart';
import 'package:flutter_geotag_mapper/presentation/bloc/exif_bloc.dart';

class DropZoneWidget extends StatefulWidget {
  const DropZoneWidget({super.key});

  @override
  State<DropZoneWidget> createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropTarget(
        onDragDone: (DropDoneDetails details) {
          setState(() {
            _dragging = false;
          });
          var files = List<ImageDataModel>.empty(growable: true);

          Future.forEach(details.files, (element) async {
            ImageDataModel file = ImageDataModel(
                element.name, element.path, await element.readAsBytes());
            files.add(file);
          }).then((value) => {
                BlocProvider.of<ExifBloc>(context)
                    .add(ExifLoadFilesEvent(files))
              });
        },
        onDragEntered: (details) {
          setState(() {
            _dragging = true;
          });
        },
        onDragExited: (details) {
          setState(() {
            _dragging = false;
          });
        },
        onDragUpdated: (details) {
          setState(() {
            _dragging = true;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
              41,
              71,
              116,
              1,
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_upload,
                  size: 100,
                  color: Colors.white,
                ),
                const Text(
                  'Drop here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Text("JPEG, PNG or TIFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                GestureDetector(
                  child: const Text(
                    'or click here to select files',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () async {
                    await FilePicker.platform
                        .pickFiles(allowMultiple: true)
                        .then((value) {
                      if (value != null) {
                        var files = value.files
                            .map((e) => ImageDataModel(
                                e.name, e.path!, e.bytes as Uint8List))
                            .toList();

                        BlocProvider.of<ExifBloc>(context)
                            .add(ExifLoadFilesEvent(files));
                      }
                    });
                  },
                ),
                if (_dragging) ...[
                  const Text(
                    'Release to drop',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
