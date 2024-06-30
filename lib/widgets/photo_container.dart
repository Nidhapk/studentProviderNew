import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/theme_provider.dart';

class PhotoContainer extends StatelessWidget {
  final String assetpath;
  final bool condition;
  final String filepath;
  const PhotoContainer(
      {super.key,
      required this.assetpath,
      required this.filepath,
      required this.condition});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: Colors.grey),
          borderRadius: BorderRadius.circular(55)),
      child: CircleAvatar(
        backgroundImage:
            condition ? AssetImage(assetpath) : FileImage(File(filepath)),
        maxRadius: 50,
      ),
    );
  }
}
