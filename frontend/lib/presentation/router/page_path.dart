/// アプリケーションのページパスを管理するクラス
class PagePath {
  static const String root = '/';
  static const String add = '/add';
  static const String edit = '/edit/:itemId';
  static const String grid = '/grid';

  /// 編集ページのパスを生成する
  static String editPath(String itemId) => '/edit/$itemId';
}
