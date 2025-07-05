
# pubspec.yaml パッケージ一覧

このプロジェクトの `pubspec.yaml` に記載されているパッケージの役割一覧です。

## dependencies

アプリケーションの実行に直接必要なパッケージです。

| パッケージ名 | 役割 |
| :--- | :--- |
| `cupertino_icons` | FlutterのCupertino（iOSスタイル）ウィジェットで使用されるアイコンアセットを提供します。 |
| `flutter_hooks` | React HooksのFlutter実装。ウィジェット間でコードを再利用しやすくします。 |
| `hooks_riverpod` | `flutter_hooks` と `riverpod` を連携させるためのパッケージ。`HookWidget` と `ConsumerWidget` の両方の機能を持つ `HookConsumerWidget` を提供します。 |
| `riverpod_annotation` | `riverpod_generator` パッケージのためのアノテーションを提供します。`@Riverpod` アノテーションを付与することで、プロバイダを自動生成します。 |
| `go_router` | URLベースのAPIを使用して宣言的なルーティングを提供し、ナビゲーションを簡素化します。 |
| `device_preview` | アプリが異なるデバイスでどのように表示され、動作するかを確認するのに役立ちます。 |
| `json_annotation` | `json_serializable` パッケージと共に使用され、JSONのシリアライズ/デシリアライズを自動化するためのアノテーションを提供します。 |
| `freezed_annotation` | `freezed` コードジェネレータのためのアノテーションを提供します。不変クラスのコード生成を簡素化します。 |
| `firebase_core` | Firebase Core APIの使用を可能にし、複数のFirebaseアプリへの接続を可能にするFlutterプラグインです。 |

## dev_dependencies

開発中にのみ必要なパッケージです。テストやコード生成などに使用されます。

| パッケージ名 | 役割 |
| :--- | :--- |
| `flutter_lints` | Flutterアプリ、パッケージ、プラグインのための推奨リントセットを提供し、良いコーディング慣行を促進します。 |
| `riverpod_generator` | Riverpodのプロバイダを生成するためのコードジェネレータ。アノテーションを使用してプロバイダの作成を簡素化します。 |
| `freezed` | 不変のデータクラスを生成するコードジェネレータ。`copyWith`、`toString`、`==`、`hashCode`などのボイラープレートコードを自動生成します。 |
| `build_runner` | コードを使用してファイルを生成する方法を提供します。定型的なタスクを自動化し、ボイラープレートコードを削減します。 |
| `json_serializable` | DartクラスをJSONとの間で変換するためのコードを自動生成します。 |
