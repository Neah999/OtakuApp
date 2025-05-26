import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/presentation/pages/item_grid_page.dart';
import 'package:frontend/presentation/pages/item_list_page.dart';
import 'package:frontend/presentation/pages/item_add_page.dart';
import 'package:frontend/presentation/pages/item_edit_page.dart';
import 'package:frontend/presentation/router/page_path.dart';

/// GoRouterのプロバイダー
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: PagePath.grid,
    routes: [
      GoRoute(
        path: PagePath.root,
        builder: (context, state) => const ItemListPage(),
      ),
      GoRoute(
        path: PagePath.add,
        builder: (context, state) => const ItemAddPage(),
      ),
      GoRoute(
        path: PagePath.edit,
        builder: (context, state) {
          final itemId = state.pathParameters['itemId'];
          return ItemEditPage(itemId: itemId);
        },
      ),
      GoRoute(
        path: PagePath.grid,
        builder: (context, state) => const ItemGridPage(),
      ),
    ],
  );
});
