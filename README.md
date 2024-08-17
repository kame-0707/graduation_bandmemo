# bandmemo

[![Image from Gyazo](https://i.gyazo.com/35c01695ae5f80b111b5ee763e70c76b.png)](https://gyazo.com/35c01695ae5f80b111b5ee763e70c76b)

## サービスURL

https://bandmemo-app.com/

## サービス概要

バンド活動をする社会人に向けた、タスク管理ツールです。具体的には、

- バンド内で、練習場所・練習中に決まる決定事項メモ・練習参考動画の共有ができます。
- バンドごとにグループを作成し、メンバーの加入申請を承認すると、メンバー内で機能を利用できます。

## このサービスへの思い・制作した理由

- 私自身が社会人をしながら趣味でバンド活動をしていた際に、メンバー集めから本番当日まで、バンド内でのタスク量が多いと感じたため。
- 時間のない社会人や学生でも、楽器練習に時間を割けるようにタスクを効率化したいと感じたため。
- 趣味で続けるバンドだからこそ、各メンバーのタスク管理を楽にすることで音楽の楽しさとより向き合えると感じたため。

## ユーザー層について

- 社会人や学生と両立しながら趣味でバンド活動をしている人
    - 時間のない人でも、効率よくバンド活動関連のタスクを管理するアプリであるため。
- バンドのリーダーを任されたが、メンバーへの情報共有の仕方に迷っている人
    - 練習場所・練習中に決まる決定事項メモ・練習参考動画の共有を1つのアプリ内で完了させることができるため、バンドメンバーが加入しているグループ内で効率よく情報共有を行うことができるため。

## サービスの利用イメージ

- バンドメンバーをアプリに招待
    - 限られたバンドメンバー内で機能を利用することができます。(個人のみでも利用可能です)
- 地図を用いたスタジオ練習場所の管理
    - 練習場所を、位置情報と共にメンバーに共有することができます。
- 練習内での決定事項をメモにまとめる・メモに対してメンバーがコメントする
    - メモをしにくい外出先やスタジオでも、音声機能を用いて仮メモの作成をすることができます。
    - 仮メモを参考にしながら、決定事項をメモ一覧に投稿することができます。
    - AI要約機能を使うと、投稿した内容を小見出し+箇条書きで分かりやすくまとめることができます。
    - 投稿されたメモに他のメンバーがコメントをすることで、決定事項に関するブラッシュアップを行うことができます。
- YouTubeの参考動画を埋め込んで共有
    - メンバー各自が参考にしている練習動画をアプリ内で共有することで、メンバー同士が共通認識を持って練習することができます。

## ユーザーの獲得について

- 社会人や学生を続けながら趣味でバンド活動をしている人は一定層いると考えております。音楽コミュニティとSNSでの拡散をはじめ、ログインをしていない場合やチームに招待されていない場合でもアプリを体験できる使い方説明を加えることで、ユーザーを増やしていきたいと考えております。

## サービスの差別化ポイント・推しポイント

- 類似サービスとして「[BAND](https://about.band.us/jp)」がありますが、本サービスでは機能面をバンド活動に特化することで差別化を図りたいと考えております。BANDは活動のジャンルを問わず利用でき、トーク機能やライブ配信・通話機能も備わっています。多くの機能の中から必要な機能を選んで使用することができる点が魅力です。
- 本アプリでは、活動ジャンルを「バンド活動」に特化することで、バンド活動をする際に必要なタスク管理が直感的にわかりやすいUIになっております。
- また、スタジオと参考動画の登録機能や、スタジオで音声仮メモ入力~メモの要約投稿という動線を作ることで、バンド活動をしているユーザーの視点に立ったサービスにしております。

## 機能(2024/8/17時点)

**【バンドグループ作成・加入】**
- グループ作成
- グループ一覧
- 加入申請(グループオーナー以外)
- 加入承認(グループオーナーのみ)

**【メイン機能】**
- スタジオ登録機能
    - オートコンプリートで住所入力
    - タイトルと練習日程の入力
    - 登録したスタジオを地図上にピンで表示
    - ピンをクリックして「Googleマップで見る」リンクを押すと、Googleマップアプリ上でもスタジオ位置を表示

- 音声文字起こしで仮メモ作成機能
    - 「録音開始」を押すと、リアルタイムで音声文字起こしを表示
    - 「録音停止」を押すと、文字起こし結果を保存して一覧に表示
    - 音声文字起こし一覧のみは、登録者本人にしか表示されない(仮メモのため)

- メモを要約・保存機能
    - 入力した内容に関して、「AI要約して保存」を押すと、小見出し+箇条書きでまとめて保存
    - 入力した内容に関して、「そのまま保存」を押すと、入力内容をそのまま保存

- メモ一覧表示機能
    - メモを要約・保存機能で保存した内容を一覧に表示
    - AI要約前の原文を確認可能
    - 投稿した一覧にいいね・コメントが可能

- 参考動画投稿機能
    - YouTubeの「共有」から埋め込みリンクを取得後、アプリ内で投稿すると埋め込み動画が一覧表示される

**【ログイン】**
- LINE認証
- Google認証
- メールアドレス認証

**【その他】**
- 使い方イメージの表示(ログイン前でも閲覧可能)
- メイン機能はバンドグループ内だけでなく、個人のみでも使用可能
- ユーザー名編集機能・ユーザー削除機能

## 今後の実装方針予定

- 各機能の一覧に関して、ページネーション・キーワードやいいねで絞る検索機能の導入
- AI要約処理中のローディング画面の設置

## 使用技術スタック

| カテゴリ | 技術 |
| --- | --- |
| フロントエンド | Rails 7.1.3.3 (Hotwire/Turbo), TailwindCSS, DaisyUI |
| バックエンド | Rails 7.1.3.3 (Ruby 3.2.3 ) |
| データベース | PostgreSQL |
| 認証 | Sorcery |
| 環境構築 | Docker |
| インフラ | Render.com |
| Web API | Google Maps JavaScript API / Google Maps Places API / Google Maps Geocording API / Web Speech API / OpenAI API |
| その他 | VCS: GitHub |

## 画面遷移図
Figma: https://www.figma.com/design/iceBBDiXRMMOOlIupKZ8rL/%E4%BA%80%E6%BE%A4_%E5%8D%92%E6%A5%AD%E5%88%B6%E4%BD%9C%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=IXuLFYm8TI1nnTZm-1

## ER図
[![Image from Gyazo](https://i.gyazo.com/b66d00e193c2ab1a00748b8e45f5554b.png)](https://gyazo.com/b66d00e193c2ab1a00748b8e45f5554b)
