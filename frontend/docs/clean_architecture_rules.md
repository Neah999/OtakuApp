
# クリーンアーキテクチャに基づくFlutterアプリ開発ルール

このドキュメントは、`docs/arc.md` と `docs/packages.md` の内容に基づき、このプロジェクトにおけるクリーンアーキテクチャのルールを定義します。

## 依存関係のルール

- **`domain`**: 他のどのレイヤーにも依存しません。純粋なビジネスロジックとデータ構造（Entity）を定義します。
- **`application`**: `domain` レイヤーにのみ依存します。アプリケーションのユースケースを定義します。
- **`infrastructure`**: `domain` レイヤーにのみ依存します。`application` レイヤーで定義されたリポジトリのインターフェースを実装し、外部のデータソース（API、DBなど）とのやり取りを担当します。
- **`presentation`**: `application` レイヤーと `domain` レイヤーに依存します。UIの表示とユーザーからの入力を担当します。

## 各レイヤーの役割と実装ルール

### `domain` レイヤー

- **`entities`**: アプリケーションのコアとなるデータ構造を `freezed` を用いて定義します。可変であってはならず、外部のライブラリに依存しません。
- **`repositories`**: `application` レイヤーで使用するリポジトリのインターフェース（抽象クラス）を定義します。具体的な実装は持ちません。

### `application` レイヤー

- **`usecases`**: アプリケーションの具体的な機能（ユースケース）を実装します。`domain` レイヤーの `repositories` に依存し、ビジネスロジックを実行します。

### `infrastructure` レイヤー

- **`data_sources`**: Firebase、API、ローカルDBなど、外部のデータソースとの通信を実装します。
- **`models`**: `json_serializable` と `freezed` を使用して、外部データソースのデータ構造を定義します。これらのモデルは `domain` レイヤーの `Entity` に変換されてから `application` レイヤーに渡されます。
- **`repositories`**: `domain` レイヤーで定義された `repositories` のインターフェースを実装します。`data_sources` を利用してデータを取得・永続化し、必要に応じて `Model` を `Entity` に変換します。

### `presentation` レイヤー

- **`pages`**: FlutterのWidgetでUIを構築します。状態管理には `hooks_riverpod` を使用し、UIのロジックは最小限に留めます。
- **`providers`**: `riverpod_generator` と `riverpod_annotation` を使用して、`application` レイヤーの `usecases` や `infrastructure` レイヤーの `repositories` をUIに提供します。状態管理のロジックはこのレイヤーに集約します。
- **`router`**: `go_router` を使用して、画面間のナビゲーションを管理します。

## パッケージ利用のルール

- **状態管理**: `hooks_riverpod`, `riverpod_generator`, `riverpod_annotation` を使用します。
- **データクラス**: `freezed`, `freezed_annotation` を使用して不変なデータクラスを生成します。
- **JSONシリアライズ**: `json_serializable`, `json_annotation` を使用します。
- **ルーティング**: `go_router` を使用します。
- **UI**: `flutter_hooks` を活用し、再利用性の高いWidgetを作成します。
- **テスト**: `flutter_test` を使用し、各レイヤーのユニットテスト、ウィジェットテストを記述します。
- **Lint**: `flutter_lints` のルールに従い、コードの品質を維持します。
