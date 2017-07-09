#! ruby
require 'json'
require 'uri'
require 'net/http'
require 'logger'
require 'yaml'

require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

## BacklogのIssue検索
def get_backlog_issues

  # ログファイル出力
  logger = Logger.new('./application.log')

  # 設定ファイルの読み込み
  config = YAML.load_file("./config.yml")

  # BASE URI
  space_name = config["backlog_space_name"]
  base_uri = "https://#{space_name}.backlog.jp/"

  # API接続認証
  auth_base_uri = "/OAuth2AccessRequest.action?"
  auth_params = URI.encode_www_form({ response_type: 'code', clientId: '' })
  auth_uri = URI.parse(base_uri + auth_base_uri + auth_params)

  # BacklogへGETリクエスト
  # APIリクエストメソッドの共通化
  begin
    response = Net::HTTP.start(auth_uri.host, auth_uri.port) do |http|
      # 接続時waitタイムアウト秒数
      http.open_timeout = 5
      # 接続時connectタイムアウト秒数
      http.read_timeout = 30
      # レスポンスの取得
      http.get(auth_uri.request_uri)
    end

    # [レスポンス処理]
    case response
    when Net::HTTPSuccess
      # JSONオブジェクトをHASHへパース
      p JSON.parse(response.body)
    when Net::HttpRedirection
      logger.warn("Redirection: code=#{response.code} message=#{response.message}")
    else
      logger.warn("HTTP error: code=#{response.code} message=#{response.message}")
    end

    # [エラーハンドリング]
  rescue IOError => e
    logger.error(e.message)
  rescue TimeoutError => e
    logger.error(e.message)
  rescue JSON::ParserError => e
    logger.error(e.message)
  rescue => e
    logger.error(e.message)
  end
end

## 不要？JSONファイルをHASHへ変換する
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

## 実行
get_backlog_issues()
