module KMExport
  def self.json_to_json(filename)
    input = IO.open(IO.sysopen(filename))
    result = []

    until input.eof?
      result << JSON.parse(input.readline)
    end
     
    output = File.open(Time.now.to_i.to_s + "_STANDARD.json", "w+")
     
    output.write(JSON.pretty_generate(result))
    output.close
  end
end
