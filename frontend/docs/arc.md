graph TD
    subgraph domain["domain（ビジネスルール層）"]
        direction TB
        entities[Entities
        （純粋なデータ構造）]
        repositories[Repositories
        （リポジトリ抽象：
        インターフェース）]
    end

    subgraph application["application
    （ユースケース層）"]
        direction TB
        usecases[Usecases
        （アプリケーションの振る舞い）]
    end

    subgraph infrastructure["infrastructure
    （外部接続・実装層）"]
        direction TB
        data_sources[Data Sources
        （DB・APIアクセス）]
        models[Models
        （外部データの構造）]
        infra_repositories[Infra Repositories
        （リポジトリ実装）]
    end

    subgraph presentation["presentation
    （UI層）"]
        direction TB
        pages[Pages
        （画面UI）]
        providers[Providers
        （状態管理・DI）]
    end

    repositories -- "Entityを扱う" --> entities
    usecases -- "抽象Repositoryに依存" --> repositories
    infra_repositories -- "Repositoryインターフェースを実装" --> repositories
    infra_repositories -- "ModelをEntityに変換" --> entities
    infra_repositories -- "データ取得に使う" --> data_sources
    infra_repositories -- "Modelを使う" --> models
    data_sources -- "Modelを返す" --> models
    providers -- "UseCaseを呼ぶ" --> usecases
    pages -- "Providerを使う" --> providers

