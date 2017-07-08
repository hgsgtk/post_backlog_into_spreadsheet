# 目的
普段Backlogでやっている課題管理のチケット漏れ検知など、
日時のルーティンでチェックしていることを自動化したい

# 現行やっていること
- 各プロジェクトを開いてそれぞれCSV出力したものを、用意したEXCELに貼り付ける。
- プロジェクトキーでソートして各ISSUEごとに、それぞれ画面を開いて「タイトル」・「概要」・「コメント」を見る。
- 各チケット担当者にリマインドを出すべきか、チケット更新するべきかを判断する。
  - 各チケット担当者にリマインドを出すべきと判断した場合、EXCEL同一行のメモに残す
  - チケット更新するべきと判断した場合、チケットを更新する。

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

## 更新処理
チケットを更新する

# Backlog API仕様
[Backlog API公式リファレンス](https://developer.nulab-inc.com/ja/docs/backlog/)

## 使用例

```
https://{space name}.backlog.jp/api/v2/issues?apiKey={API AccessKey}&projectId%5B%5D={project id}
```

## 中継処理
### Backlogから取得したjsonをgoogle spreadsheetに書き込むためのjsonに整形する

### jsonファイルをHASH変換

```
File.open('backlog_issues.json') do |file|
  hash = JSON.load(file)
  p hash
end
```

取り出した結果
```
[{"id"=>2489264, "projectId"=>55351, "issueKey"=>"xxx", "keyId"=>41, "issueType"=>{"id"=>251087, "projectId"=>55351, "name"=>"タスク", "color"=>"#7ea800", "displayOrder"=>0}, "summary"=>"xxx", "description"=>"xxx", "resolution"=>nil, "priority"=>{"id"=>3, "name"=>"中"}, "status"=>{"id"=>1, "name"=>"未対応"}, "assignee"=>{"id"=>122253, "userId"=>"xxx", "name"=>"xxx", "roleType"=>2, "lang"=>nil, "mailAddress"=>"xxx", "nulabAccount"=>nil}, "category"=>[], "versions"=>[], "milestone"=>[], "startDate"=>nil, "dueDate"=>"2017-07-21T00:00:00Z", "estimatedHours"=>nil, "actualHours"=>nil, "parentIssueId"=>nil, "createdUser"=>{"id"=>42269, "userId"=>"xxx", "name"=>"xxx", "roleType"=>1, "lang"=>"ja", "mailAddress"=>"xxx", "nulabAccount"=>nil}, "created"=>"2017-07-06T10:40:22Z", "updatedUser"=>{"id"=>42269, "userId"=>"xxx", "name"=>"xxx", "roleType"=>1, "lang"=>"ja", "mailAddress"=>"xxx", "nulabAccount"=>nil}, "updated"=>"2017-07-06T10:40:22Z", "customFields"=>[{"id"=>26992, "fieldTypeId"=>5, "name"=>"領域", "value"=>nil}], "attachments"=>[{"id"=>1209615, "name"=>"xxx", "size"=>47247, "createdUser"=>{"id"=>42269, "userId"=>"xxx", "name"=>"xxx", "roleType"=>1, "lang"=>"ja", "mailAddress"=>"xxx", "nulabAccount"=>nil}, "created"=>"2017-07-06T10:40:22Z"}], "sharedFiles"=>[], "stars"=>[]}
```
###

### jsonの書き込み

```
## HASHをJSONファイルに書き出す
def output_json_from_hash(output_hash)
  output_json = JSON.generate(output_hash)
  puts output_json
end
```

# 参考情報
## Spreadsheet API v4仕様
### 公式リファレンス

### API URI
* Base URL https://sheets.googleapis.com/v4/spreadsheets

* Update URI
https://sheets.googleapis.com/v4/spreadsheets/{spreadsheetId}/values:batchUpdate

### 書き込む

### 枠線を入れる

## 初回実行時に実行（phase1対象外）
* ファイルの作成
* 条件付き書式を入れる

```
https://sheets.googleapis.com/v4/spreadsheets/{spreadsheetId}:batchUpdate
```

## 参考URL
* [Googleスプレッドシートをプログラムから操作](http://qiita.com/howdy39/items/ca719537bba676dce1cf)
* [Google Sheets > API v4](https://developers.google.com/sheets/api/reference/rest/)
