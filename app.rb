#! ruby
require 'json'
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

## 起動

## BacklogのIssue検索
def get_backlog_issues
  # BASE URI
  space_name = ''
  base_uri = "https://#{space_name}.backlog.jp/"

  # API接続認証
  auth_base_uri = "/OAuth2AccessRequest.action?"
  auth_parameter = ""
  apiKey = ""
  auth_uri = base_uri + auth_base_uri + auth_parameter + apiKey
  puts auth_uri
  if

  # Issue検索条件の指定

  # APIを呼び出しIssueを検索、取得する
end

get_backlog_issues()

## JSONファイルをHASHへ変換する
def convert_json_to_hash(file_name)
  # JSON->HASH
  File.open(file_name) do |file|
    @converted_hash = JSON.load(file)
  end
end
  # HASH->JSON

## HASHをJSONファイルに書き出す
def output_json_from_hash(output_hash)
  output_json = JSON.generate(output_hash)
  puts output_json
end

## google spreadsheet API形式のHASHに変換
def shaping_hash(input_hash)

end

##
