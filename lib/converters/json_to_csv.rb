module KMExport
  def self.json_to_csv(jsonfile)
    default_headers = ["_n", "_p", "_t", "_p2", "_a"]
    headers = []
    file = File.open(jsonfile)
    json = JSON.parse(file.read)
    results = []
    json.each do |row|
      headers = headers | row.keys
    end

    json.each do |row|
      row_result = {}
      headers.each do |header|
        row_result[header.to_sym] = row[header] || ""
      end
      results << row_result
    end
    
    CSV.open(Time.now.to_i.to_s + "_converter_result.csv", "wb") do |csv|
      csv << results.first.keys
      results.each do |hash|
        csv << hash.values
      end
    end
  end
end