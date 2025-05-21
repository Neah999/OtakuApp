import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // DevicePreviewをインポート
import 'package:your_app_name/app_router.dart'; // app_router.dartをインポート

void main() {
  runApp(
    DevicePreview( // DevicePreviewでMyAppをラップ
      enabled: true, // デバイスプレビューを有効にするかどうか (リリースビルドではfalseにすることを推奨)
      builder: (context) => const MyApp(), // MyAppを渡す
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // DevicePreviewを使用する場合、builderとlocaleを設定
      locale: DevicePreview.locale(context), // DevicePreviewのロケールを使用
      builder: DevicePreview.appBuilder, // DevicePreviewのビルダーを使用
      routerConfig: appRouter, // app_router.dartで定義したルーターを使用
    );
  }
}
