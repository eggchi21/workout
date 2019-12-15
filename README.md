# アプリケーションの概要
## 制作の背景
**120kg**の巨漢だった私は、昨年、**315日間**ダイエットをして、フィジークの大会に出場しました。ダイエット期間中、体重の減り具合が芳しくなかったり、誘惑に負けそうになって不安になることがありましたが、Twitterに毎日体型の自撮りと体重、摂取カロリーをアップロードすることで、自制心を保つことができました。中にはエールをくれる同志がいて、Webでつながることに素晴らしさを覚えました。
この経験から、**ダイエットの不安を解消してくれるアプリを作ってみたい**と思い、同志と目標をシェア、食事・体重の増減経過のサポートを担うアプリの制作に至りました。
### アクセス
[コチラ](http://3.115.172.75)からアクセスできます。

## こだわり機能
- ArrayクラスをRubyのRefinementで拡張し、作成したオリジナルの統計メソッド
- Google Cloud Vision APIを使用した画像解析
- WebサイトからScrapingした情報を用いてカロリー/PFCバランスの非同期で計算

- その他の機能は「アプリケーションの機能一覧」よりご確認ください

## コンセプト

### 「ダイエット×確率統計×目標シェア」
体重を毎日記録することで、将来の体重を確率統計で導きます。
ダイエットの知識がない人でもカンタンにはじめられるように、目標設定のサポート、
たべもの図鑑から食べたものを記録、カロリー/PFCバランスの計算結果をグラフ化します
[![Image from Gyazo](https://i.gyazo.com/1c3b2f518a3025bee3c4840a5c9f2d77.gif)](https://gyazo.com/1c3b2f518a3025bee3c4840a5c9f2d77)
[![Image from Gyazo](https://i.gyazo.com/945cdbd973a745b82112b68b0fbd51de.gif)](https://gyazo.com/945cdbd973a745b82112b68b0fbd51de)
[![Image from Gyazo](https://i.gyazo.com/60804fb6ddd8921820169ddd90e6b7e2.gif)](https://gyazo.com/60804fb6ddd8921820169ddd90e6b7e2)
# アプリケーションの機能一覧
- sessionを使用したウイザード形式でのユーザ新規登録機能/ログイン機能
- 郵便番号から住所を自動入力する機能
- 各種投稿(体重/目標/食事)の新規作成・編集・削除・一覧機能
- 複数画像プレビュー表示/投稿機能
- JavaScriptチャートライブラリの[amCharts](https://www.amcharts.com/)に独自のカスタマイズを加えたグラフの生成
- 最小二乗法を使用し、1週間後の体重を予測する機能
- カロリー・PFCバランスの非同期計算
- [カロリーSlism](https://calorie.slism.jp/)から食品のカロリー等の情報をスクレイピング
- Ajaxで"たべもの"検索機能(インクリメンタルサーチ)
- 経路列挙モデルで関連付けた"たべもの"の親子関係を一覧で表示させる機能
- 食べ物を頭文字で分類する機能
- いいね機能
- SNS(Facebook,Google)経由でユーザー新規登録機能/ログイン機能
- [Google Cloud Vision API](https://cloud.google.com/vision/?hl=ja)を使用して商品パッケージ写真からPFCを識別する

# アプリケーション内で使用している主な技術一覧
| 種別 | 名称 |
|-----|:---:|
| 開発言語 | Ruby(ver 2.5.1) |
| フレームワーク | Ruby on Rails(ver 5.2.3) |
| マークアップ | HTML(Haml),CSS(Sass) |
| フロントエンド | JavaScript(jQuery) |
| グラフ描画 | amCharts |
| 日付入力 | jQueryUI Datepicker |
| スクレイピング | gem 'mechanize' |
| 数学的処理 | 確率統計(最小二乗法,分散,共分散) |
| DB | MySQL |
| テスト | RSpec |
| 本番環境 | AWS EC2 |
| 画像アップロード | Active Storage, AWS S3 |
| 自動デプロイ | capistrano |
| メモリ不足対策 | gem 'unicorn-worker-killer' |

# 実装予定の機能
- csvで体重の記録を抽出する機能
- LINEBotから体重記録
- 増量プランの追加
- 重回帰分析の導入
- フォロー機能
- 日々の画像を比較する機能

# ER図
gem 'rails-erd'で自動生成
[![Image from Gyazo](https://i.gyazo.com/ec43e40b25c0f2546e1e55f1e74f921c.png)](https://gyazo.com/ec43e40b25c0f2546e1e55f1e74f921c)

# GitHubからインストール

```
$ git clone https://github.com/eggchi21/workout.git
$ cd workout
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails server
```

## ログイン
1. TOPページ中部の"Start This APP"をクリックしてください
[![Image from Gyazo](https://i.gyazo.com/e2c5d65fba6398236363f77573a4e90c.gif)](https://gyazo.com/e2c5d65fba6398236363f77573a4e90c)
2. テストユーザー(sample1@sample.com)が入力されているので、そのままログインボタンを選択してください
※SNS経由でのログインはローカル環境のみで適用させてます
[![Image from Gyazo](https://i.gyazo.com/e0210b75366139c7ac9b224d486d2798.gif)](https://gyazo.com/e0210b75366139c7ac9b224d486d2798)

## 体重を記録する
1. メニュー(画面左上の三本線)から"体重を記録する"を選択してください
[![Image from Gyazo](https://i.gyazo.com/d95fdca8f5a97db8a9b4af3ac968bf6e.gif)](https://gyazo.com/d95fdca8f5a97db8a9b4af3ac968bf6e)
2. 各種フォームを入力してください　体重と日付は必須項目です
同じ日付は登録できないようにバリデーションを実装してあるので、日付を変更するか、他のユーザーでログインしていただく必要がある場合があります。
(他のユーザーはメールアドレスの「sample"数字"@sample.com」の"数字"を1~9のうちいずれかにしてください。パスワードはすべて同じで"password"です)
[![Image from Gyazo](https://i.gyazo.com/de704f972496328e9d1dd0795d2bf135.gif)](https://gyazo.com/de704f972496328e9d1dd0795d2bf135)
3. 体重一覧ページに遷移します。直近の１週間分の体重が表示されてグラフ下部のバーを調節する/右上のマイナスボタンを押すことで目的の範囲のグラフを描画できます
ページ右上には**最小二乗法で算出された、1週間後の体重**が表示されています
[![Image from Gyazo](https://i.gyazo.com/f8852e978f9796e33784ab358df9882a.gif)](https://gyazo.com/f8852e978f9796e33784ab358df9882a)
4. グラフの点すると編集画面へ遷移します
[![Image from Gyazo](https://i.gyazo.com/5eda8549474a4ce8d275976e7f95c6bb.gif)](https://gyazo.com/5eda8549474a4ce8d275976e7f95c6bb)

## 目標を設定する
1. メニュー(画面左上の三本線)から"みんなの目標"を選択してください
2. 目標が設定されてなければ、”目標を作成する”ボタンが表示されるので選択してください
[![Image from Gyazo](https://i.gyazo.com/4cfa57025698a4a7afc32551f8fbe20b.gif)](https://gyazo.com/4cfa57025698a4a7afc32551f8fbe20b)
3. テストユーザーのユーザー情報が不足していれば、ユーザー情報更新ページに遷移するので、各種フォームに必要事項を入力してください
[![Image from Gyazo](https://i.gyazo.com/8f768267b8a4cb7dabc5b76e29924ba4.gif)](https://gyazo.com/8f768267b8a4cb7dabc5b76e29924ba4)
4. 必要事項を入力していくと自動で次の入力フォームが出現します　要件に満たない場合はアドバイスが表示されます
[![Image from Gyazo](https://i.gyazo.com/0342b1fdf051f3e51dce17574c0842c4.gif)](https://gyazo.com/0342b1fdf051f3e51dce17574c0842c4)
5. ダイエット方法によって最適なPFCバランスを提案します 登録できるような状態の数値であれば"設定する"ボタンが表示されるので選択してください
[![Image from Gyazo](https://i.gyazo.com/183d0a46417bb0a0e0a445ba2d0389d0.gif)](https://gyazo.com/183d0a46417bb0a0e0a445ba2d0389d0)
6. "自分の目標を確認する"から編集・削除ができます
[![Image from Gyazo](https://i.gyazo.com/c0a45da0d719e285d3ada565d67a2519.gif)](https://gyazo.com/c0a45da0d719e285d3ada565d67a2519)

## 食事を記録する
1. メニュー(画面左上の三本線)から"食事を記録する"を選択してください
[![Image from Gyazo](https://i.gyazo.com/696facd4f86d3056bca35654b056f735.gif)](https://gyazo.com/696facd4f86d3056bca35654b056f735)
2. 検索欄に文字を入力して、候補から食事を選択してください
[![Image from Gyazo](https://i.gyazo.com/03b2c5ddf0b35cce5cb46c79fbb3f788.gif)](https://gyazo.com/03b2c5ddf0b35cce5cb46c79fbb3f788)
3. 表の"個数”,”グラム”を変更すると自動でPFCバランス/カロリーが計算されます
[![Image from Gyazo](https://i.gyazo.com/b501febdbe326c668c8497e7e50a1386.gif)](https://gyazo.com/b501febdbe326c668c8497e7e50a1386)
4. 削除もできます 完了したら"記録する"ボタンを選択してください。
[![Image from Gyazo](https://i.gyazo.com/ec5a2a21c6e1961cbe32ffd08169fc82.gif)](https://gyazo.com/ec5a2a21c6e1961cbe32ffd08169fc82)
5. 任意の棒グラフを選択すると編集画面へ遷移します
[![Image from Gyazo](https://i.gyazo.com/945cdbd973a745b82112b68b0fbd51de.gif)](https://gyazo.com/945cdbd973a745b82112b68b0fbd51de)
6. また、たべもの図鑑から食べ物を検索できます。
[![Image from Gyazo](https://i.gyazo.com/40b4bf8057b98605032ed5772c5ff4b7.gif)](https://gyazo.com/40b4bf8057b98605032ed5772c5ff4b7)
[![Image from Gyazo](https://i.gyazo.com/fbcc9d1d5860299cd051263248c1c0a3.gif)](https://gyazo.com/fbcc9d1d5860299cd051263248c1c0a3)

## オリジナルのたべものを登録する
※ローカル環境のみで適用させてます
1. メニュー(画面左上の三本線)から"たべもの登録"を選択してください
[![Image from Gyazo](https://i.gyazo.com/920630e25a258aca8ca7673c432ebe84.gif)](https://gyazo.com/920630e25a258aca8ca7673c432ebe84)
2. "画像からPFCを取得する"を選択してください
成分表示が記載された商品パッケージを選んでください
[![Image from Gyazo](https://i.gyazo.com/af959f2bd8c5c45dc00be9d6493be479.gif)](https://gyazo.com/af959f2bd8c5c45dc00be9d6493be479)
3. 画像を解析して、たんぱく質/脂質/炭水化物の含有量(g)がフォームに入力されます
[![Image from Gyazo](https://i.gyazo.com/66aa4bbbf4cbd8d892cdb26c6c77ce3a.gif)](https://gyazo.com/66aa4bbbf4cbd8d892cdb26c6c77ce3a)
[![Image from Gyazo](https://i.gyazo.com/adb572de9dbd7419673d9e2adff010a3.gif)](https://gyazo.com/adb572de9dbd7419673d9e2adff010a3)
# 作者
- Qiita: [@eggchi21](https://qiita.com/eggchi21)
- Mail: 52.eguchi.keita@mail.com

# ライセンス
The MIT License (MIT)
Copyright © 2019 <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.