require 'json'

## JSONファイルをHASHへ変換する
def convert_json_to_hash(file_name)
  # JSON->HASH
  File.open(file_name) do |file|
    @converted_hash = JSON.load(file)
  end
end
  # HASH->JSON

  ## str = JSON.generate({:hello => "good bye"})
  puts @converted_hash.to_json
end

convert_json_to_hash('backlog_issues.json')
