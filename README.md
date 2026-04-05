# Maya Sandbox Launcher

学校PCのMaya起動環境をサンドボックス化するランチャースクリプト。  
起動のたびに環境をリセットし、学生ごとの設定汚染を防ぐ。

## 概要

このリポジトリのスクリプトは直接配布せず、[maya-sandbox-installer](https://github.com/iput-technical-artist-group/maya-sandbox-installer) 経由でインストールされたクライアントスクリプトが起動時にGitHubから取得して実行する。

## 動作内容

1. インストール済みの最新Mayaを自動検出
2. 実行中のMayaプロセスを終了
3. サンドボックスディレクトリ（`%USERPROFILE%\sandbox`）をリセット
4. 環境変数をサンドボックスパスで上書き
5. Mayaを起動

## サンドボックス構成

| ディレクトリ | 環境変数 |
|---|---|
| `sandbox\scripts` | `PYTHONPATH`, `MAYA_SCRIPT_PATH` |
| `sandbox\prefs` | `XBMLANGPATH`, `MAYA_PRESET_PATH` |
| `sandbox\shelves` | `MAYA_SHELF_PATH` |
| `sandbox\plug-ins` | `MAYA_PLUG_IN_PATH` |
| `sandbox\modules` | `MAYA_MODULE_PATH` |

## スクリプトの更新方法

このリポジトリの `maya_sandbox_launcher.bat` を編集してpushするだけで、全クライアントPCが即時に使用できるようになる。

## 関連リポジトリ

| リポジトリ | 役割 |
|---|---|
| [maya-sandbox-installer](https://github.com/iput-technical-artist-group/maya-sandbox-installer) | クライアントPCへの初期セットアップ |
| [maya-sandbox-launcher](https://github.com/iput-technical-artist-group/maya-sandbox-launcher)（本リポジトリ） | 起動時にGitHubから取得される本体スクリプト |