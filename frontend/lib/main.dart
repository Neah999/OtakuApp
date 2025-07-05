import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/presentation/router/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infrastructure/data_sources/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const ProviderScope(child: App()),
    ),
  );
}
