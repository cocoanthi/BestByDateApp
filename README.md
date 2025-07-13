# BestByDateApp

BestByDateAppは、SwiftUIを用いた賞味期限管理アプリです。

## 主な機能
- 賞味期限アイテムの登録・編集・削除
- グループごとのアイテム管理
- 期限切れ通知機能
- API連携によるデータ取得・更新

## ディレクトリ構成
- `BestByDateApp/` : アプリ本体
  - `Data/` : データ層（リポジトリ、APIリクエスト、モデル）
  - `Domain/` : ドメイン層（リクエスト、モデル、ViewModel）
  - `Extension/` : Swift拡張
  - `View/` : 画面・UIコンポーネント
- `BestByDateApp.xcodeproj/` : Xcodeプロジェクトファイル
- `BestByDateApp.xcworkspace/` : Xcodeワークスペース

## 開発環境
- macOS
- Xcode 15以降
- Swift 5.9以降

## セットアップ方法
1. リポジトリをクローン
   ```sh
   git clone https://github.com/cocoanthi/BestByDateApp.git
   ```
2. Xcodeで`BestByDateApp.xcworkspace`を開く
3. 必要に応じて`project.yml`を使い[xcodegen](https://github.com/yonaskolb/XcodeGen)でプロジェクトを再生成
   ```sh
   xcodegen
   ```

## ビルド・実行
Xcodeでターゲット`BestByDateApp`を選択し、シミュレータまたは実機で実行してください。

## ライセンス
MIT License

---

ご質問・不具合報告は[Issues](https://github.com/cocoanthi/BestByDateApp/issues)までお願いします。# BestByDateApp

BestByDateAppは、SwiftUIを使用して賞味期限管理を行うiOSアプリです。

## 主な機能
- 賞味期限アイテムの登録・編集・削除
- グループごとのアイテム管理
- 通知機能による期限切れのリマインド
- API連携によるデータ取得・更新

## ディレクトリ構成
- `BestByDateApp/` : アプリ本体
  - `Data/` : データ層（リポジトリ、APIリクエスト、モデル）
  - `Domain/` : ドメイン層（リクエスト、モデル、ViewModel）
  - `Extension/` : Swift拡張
  - `View/` : 画面・UIコンポーネント
- `BestByDateApp.xcodeproj/` : Xcodeプロジェクトファイル
- `BestByDateApp.xcworkspace/` : Xcodeワークスペース

## 開発環境
- macOS
- Xcode 15以降
- Swift 5.9以降

## セットアップ方法
1. リポジトリをクローン
   ```sh
   git clone https://github.com/cocoanthi/BestByDateApp.git
   ```
2. Xcodeで`BestByDateApp.xcworkspace`を開く
3. 必要に応じて`project.yml`を使い[xcodegen](https://github.com/yonaskolb/XcodeGen)でプロジェクトを再生成
   ```sh
   xcodegen
   ```

## ビルド・実行
Xcodeでターゲット`BestByDateApp`を選択し、シミュレータまたは実機で実行してください。

## ライセンス
MIT License

---

ご質問・不具合報告は[Issues](https://github.com/cocoanthi/BestByDateApp/issues)までお願いします。
