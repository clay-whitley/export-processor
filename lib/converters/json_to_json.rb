module KMExport
  def self.json_to_json
    files = Dir["*.json"]
 
    result = []
     
    files.each do |file|
      json = File.open(file, "r")
      json.readlines.each do |line|
        result << JSON.parse(line.chomp)
      end
    end
     
    output = File.open(Time.now.to_i.to_s + "_result.json", "w+")
     
    output.write(JSON.pretty_generate(result))
    output.close
  end
end
