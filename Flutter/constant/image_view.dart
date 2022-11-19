import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImage extends StatelessWidget {
  final name;

  const FullImage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: PhotoView(
        imageProvider: FileImage(File(name)),
      )),
    );
  }
}
