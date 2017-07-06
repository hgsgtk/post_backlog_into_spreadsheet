# 目的
普段Backlogでやっている課題管理のチケット漏れ検知など、
日時のルーティンでチェックしていることを自動化したい

# 概要
## Issueの取得
- 関連する課題一覧を取得する
- 任意のタイミングで起動可能とする

## Issueの表示
- 期限日が3日以内になっているものは注意アラート
- 過去のチケットとなっているものは警告アラート
- 期限日が設定されていない課題は期限日を設定する必要がある旨を明示する
- 担当者ごとに課題を分類する。分類した課題は「プロジェクト」・「課題名」・「期限日」を表示
- それぞれの課題からリンクが貼られており飛べることとする。

# 仕様詳細
## システム概要
"google spreadsheet" => "backlog API"

## 事前に設定するマスタ情報
- 担当者の所属会社
所属会社ごとに「うちボール」か「先方ボール」かを見たいため。
- ウォッチするプロジェクト

## パラメータ設定とする項目
- リクエスト先のBASE URL
- アラート対象とする?日以内の?

## 表示する対象アプリケーション
「google spreadsheet」へ取得した情報を渡すことを想定

## 起動トリガー
案1：google spreadsheetをトリガーにする
案2：lambdaを仲介するAPIとする。　
※json整形と取得するjsonファイルサイズによって検討

## 表示制御
google spreadsheetの「条件付き書式」で制御

# Backlog API仕様
[Backlog API公式リファレンス](https://developer.nulab-inc.com/ja/docs/backlog/)

## 使用例
'''
https://{space name}.backlog.jp/api/v2/issues?apiKey={API AccessKey}&projectId%5B%5D={project id}
'''

# Google Spreadsheet API仕様
- jsonファイルの整形
```

```
- jsonの書き込み
```
https://sheets.googleapis.com/v4/spreadsheets/1bxJfPp09tBBYm0tjLWzy0MgInzWw_W1wtzwyEf8CTqM:batchUpdate
```
