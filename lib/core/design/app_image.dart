import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? height, width;
  final BoxFit fit;

  const AppImage({Key? key,
    required this.path,
        this.height,
        this.width,
        this.fit = BoxFit.scaleDown
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.endsWith("svg")) {
      return SvgPicture.asset(
        path,
        fit: fit,
        height: height,
        width: width,
      );
    } else if (path.startsWith("http")) {
      return Image.network(
        path,
        fit: fit,
        height: height,
        width: width,
      );
    } else if(path.contains("assets")) {
      return Image.asset(
        path,
        fit: fit,
        height: height,
        width: width,
      );
    }else{
      return Image.file(
        File(path),
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
}
