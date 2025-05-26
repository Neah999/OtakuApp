import 'package:flutter/material.dart';

/// アプリケーションのAppBar
class ItemAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// AppBarの種類
  final AppBarType type;

  /// アクションボタンのコールバック
  final VoidCallback? onActionPressed;

  const ItemAppBar({
    super.key,
    required this.type,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppBarType.list:
        return AppBar(
          title: const Text('グッズ一覧'),
          centerTitle: true,
          foregroundColor: Colors.white,
          elevation: 4,
          actions: [
            IconButton(
              icon: const Icon(Icons.grid_view),
              onPressed: onActionPressed,
            ),
          ],
        );

      case AppBarType.grid:
        return AppBar(
          title: const Text('グッズ一覧'),
          centerTitle: true,
          foregroundColor: Colors.white,
          elevation: 4,
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: onActionPressed,
            ),
          ],
        );

      case AppBarType.add:
        return AppBar(
          title: const Text('グッズ追加'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onActionPressed,
          ),
        );

      case AppBarType.edit:
        return AppBar(
          title: const Text('グッズ編集'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onActionPressed,
          ),
        );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// AppBarの種類を定義する列挙型
enum AppBarType {
  /// 一覧画面用
  list,

  /// グリッド表示用
  grid,

  /// 追加画面用
  add,

  /// 編集画面用
  edit,
}
