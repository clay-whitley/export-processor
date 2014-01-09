module KMExport
  def self.alias_parser(jsonfile)
    file = File.open(jsonfile)
    alias_file = File.open(Time.now.to_i.to_s + "_aliases.json", "w+")
    json = JSON.parse(file.read)
    aliases = []
    data = []

    json.each do |row|
      if row["_p2"]
        aliases << row
      else
        data << row
      end
    end
    new_file = File.open(jsonfile, "w+")
    new_file.write(JSON.pretty_generate(data))
    alias_file.write(JSON.pretty_generate(aliases))
    new_file.close
    alias_file.close
  end
end