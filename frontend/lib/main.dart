import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:frontend/presentation/pages/item_grid_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/presentation/pages/item_list_page.dart';
import '/presentation/pages/item_add_page.dart'; // 新規追加ページをインポート
import 'presentation/pages/item_edit_page.dart'; // 編集ページをインポート

void main() {
  runApp(
    DevicePreview(
      enabled: true, // デバイスプレビューを有効にする
      builder: (context) => const ProviderScope(child: MyApp()),
    ),
  );
}

// GoRouterの設定
final _router = GoRouter(
  // initialLocation: '/grid',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ItemListPage(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const ItemAddPage(), // 新規追加ページにルーティング
    ),
    GoRoute(
      path: '/edit/:itemId',
      builder: (context, state) {
        final itemId = state.pathParameters['itemId'];
        return ItemEditPage(itemId: itemId); // 編集ページにルーティング
      },
    ),
    GoRoute(
      path: '/grid',
      builder: (context, state) => const ItemGridPage(),
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'アイテム管理アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // フォントを設定
      ),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      routerConfig: _router,
    );
  }
}