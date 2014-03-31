module KMExport
  def self.json_to_csv(jsonfile)
    headers = []
    csv_filename = Time.now.to_i.to_s + "_converter_result.csv"
    input = IO.open(IO.sysopen(jsonfile))
    output = CSV.open(csv_filename, "w+")
    
    until input.eof?
      headers = headers | JSON.parse(input.readline).keys
    end

    output << headers
    input.rewind

    until input.eof?
      row_data = JSON.parse(input.readline)
      row_result = {}
      headers.each do |header|
        row_result[header.to_sym] = row_data[header] || ""
      end
      output << row_result.values
    end
  end
end