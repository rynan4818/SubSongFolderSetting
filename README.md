# SubSongFolderSetting
BeatSaberのカスタムソングフォルダを追加する設定ツールです。

[SongCore](https://github.com/Kylemc1413/SongCore)のfolders.xmlを編集するGUIツールになります。

![image](https://rynan4818.github.io/SubSongFolderSetting.png)

# 使用方法
[リリースページ](https://github.com/rynan4818/SubSongFolderSetting/releases)から最新のzipファイルをダウンロードして、適当なフォルダに解凍して、SubSongFolderSetting.exeを起動して下さい。

使い方は上の画像を見ればわかると思います。

**Path や Name は日本語などのマルチバイト（全角文字）は不可です。半角英数記号(ASCII文字)のみにして下さい。**

# ライセンスと著作権について

onesaber_convert はプログラム本体と各種ライブラリから構成されています。

onesaber_convert のソースコード及び各種ドキュメントについての著作権は作者であるリュナン(Twitter [@rynan4818](https://twitter.com/rynan4818))が有します。
ライセンスは MIT ライセンスを適用します。

それ以外の onesaber_convert.exe に内包しているrubyスクリプトやバイナリライブラリは、それぞれの作者に著作権があります。配布ライセンスは、それぞれ異なるため詳細は下記の入手元を確認して下さい。

# 開発環境、各種ライブラリ入手先

各ツールの入手先、開発者・製作者（敬称略）、ライセンスは以下の通りです。

bs-mapdown-assistant.exe に内包している具体的なライブラリファイルの詳細は [Exerbレシピファイル](source/core_cui.exy) を参照して下さい。

## Ruby本体入手先
- ActiveScriptRuby(1.8.7-p330)
- https://www.artonx.org/data/asr/
- 製作者:arton
- ライセンス：Ruby Licence

## GUIフォームビルダー入手先
- FormDesigner for Project VisualuRuby Ver 060501
- https://ja.osdn.net/projects/fdvr/
- Subversion リポジトリ r71(r65以降)の/formdesigner/trunk を使用
- 開発者:雪見酒
- ライセンス：Ruby Licence

## 使用拡張ライブラリ、ソースコード

### Ruby本体 1.8.7-p330              #開発はActiveScriptRuby(1.8.7-p330)を使用
- https://www.ruby-lang.org/ja/
- 開発者:まつもとゆきひろ
- ライセンス：Ruby Licence

### Exerb                            #開発はActiveScriptRuby(1.8.7-p330)同封版を使用
- http://exerb.osdn.jp/man/README.ja.html
- 開発者:加藤勇也
- ライセンス：LGPL

### gem                              #開発はActiveScriptRuby(1.8.7-p330)同封版を使用
- https://rubygems.org/
- ライセンス：Ruby Licence

### VisualuRuby                      #開発はActiveScriptRuby(1.8.7-p330)同封版を使用 ※swin.soを改造
- http://www.osk.3web.ne.jp/~nyasu/software/vrproject.html
- 開発者:にゃす
- ライセンス：Ruby Licence

### json-1.4.6-x86-mswin32
- https://rubygems.org/gems/json/versions/1.4.6
- https://rubygems.org/gems/json/versions/1.4.6-x86-mswin32
- 開発者:Florian Frank
- ライセンス：Ruby Licence

### DLL

#### libiconv 1.11  (iconv.dll)       #Exerbでbs_movie_cut.exeに内包
- https://www.gnu.org/software/libiconv/
- Copyright (C) 1998, 2019 Free Software Foundation, Inc.
- ライセンス：LGPL
