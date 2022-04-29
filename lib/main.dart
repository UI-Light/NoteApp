import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false, //!kReleaseMode,
      builder: (context) => App(),
    ),
  );
}
