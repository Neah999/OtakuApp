import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/presentation/router/app.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const ProviderScope(child: App()),
    ),
  );
}
