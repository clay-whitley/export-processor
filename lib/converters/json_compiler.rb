module KMExport
  def self.json_compiler
    files = Dir["*.json"]
    result = []
    filename = "#{Time.now.to_i.to_s}_result.json"
    File.open(filename, "w+").close
    output = IO.open(IO.sysopen(filename, "w"), "w")

    files.each do |file|
      input = IO.open(IO.sysopen(file))
      until input.eof?
        output.write(input.readline)
      end
    end
  end
end