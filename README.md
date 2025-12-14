# MyAHK

AutoHotkey v2 を使用した個人用スクリプトプロジェクトです。

## 概要

このプロジェクトは AutoHotkey v2 で作成されたホットキー・ユーティリティスクリプト集です。
可読性と保守性を重視し、モジュール分割された構成になっています。

## 必要要件

- **AutoHotkey v2.0 以降**
- Windows 環境
- Visual Studio Code（推奨）
  - AutoHotkey v2 対応拡張機能の使用を推奨

## ファイル構成

```
MyAHK/
├── .github/
│   └── copilot-instructions.md  # GitHub Copilot 用開発方針
├── build/                        # ビルド成果物（配布用）
├── src/
│   ├── main.ahk                  # エントリースクリプト
│   ├── hotkeys.ahk               # ホットキー定義（一元管理）
│   └── lib/
│       └── log.ahk               # ロギングユーティリティ
└── README.md
```

## 使い方

### スクリプトの実行

```powershell
cd src
.\main.ahk
```

または、エクスプローラーから `src\main.ahk` をダブルクリックして実行します。

### デフォルトのホットキー

- **Ctrl+Alt+T**: テストメッセージを表示
- **Ctrl+Alt+R**: スクリプトをリロード
- **ahkv2** と入力: 「AutoHotkey v2」に展開（ホットストリング）

### ログの確認

ログは `OutputDebug` で出力されます。[DebugView](https://learn.microsoft.com/en-us/sysinternals/downloads/debugview) などのツールで確認できます。

## 開発方針

このプロジェクトは以下の方針で開発されています:

- **AutoHotkey v2 のみを使用**（v1 構文は使用しない）
- 可読性と保守性を最優先
- 式構文（expression syntax）を使用
- コメントは日本語で記述
- 関数ベースの設計

詳細は [.github/copilot-instructions.md](.github/copilot-instructions.md) を参照してください。

## カスタマイズ

### ホットキーの追加

`src/hotkeys.ahk` にホットキー定義を追加します。

```ahk
; Ctrl+Alt+H: Hello World を表示
^!h:: {
    MsgBox("Hello World", "MyAHK")
}
```

### ロギングの使用

`log.ahk` のログ関数を使用できます。

```ahk
#Include lib\log.ahk

log("情報メッセージ")
logWarning("警告メッセージ")
logError("エラーメッセージ", true)  ; 第2引数を true にするとユーザーに通知
```

## ライセンス

個人用プロジェクトです。
