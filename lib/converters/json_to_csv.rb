module KMExport
  def self.json_to_csv(jsonfile)
    DEFAULT_HEADERS = ["_k", "_n", "_p", "_t"]
    headers = []
    file = File.open(jsonfile)
    json = JSON.parse(file.read)
    json.each do |row|
      headers = headers | row.keys
    end
    p headers
  end
end