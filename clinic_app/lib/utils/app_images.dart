import 'package:flutter/material.dart';

bool _isNetworkImage(String path) =>
    path.startsWith('http://') || path.startsWith('https://');

ImageProvider appImageProvider(String path) {
  return _isNetworkImage(path) ? NetworkImage(path) : AssetImage(path);
}

Widget appImage(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
  Widget? fallback,
}) {
  Widget errorBuilder(BuildContext context, Object error, StackTrace? stack) {
    return fallback ??
        Container(
          width: width,
          height: height,
          color: Colors.black12,
          child: const Icon(Icons.image_not_supported_outlined),
        );
  }

  if (_isNetworkImage(path)) {
    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: errorBuilder,
    );
  }

  return Image.asset(
    path,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: errorBuilder,
  );
}
