#! ruby
require 'json'
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

## 起動

## BacklogのIssue検索

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
