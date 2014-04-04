module KMExport
  def self.identity_parser(jsonfile, identity)
    input = IO.open(IO.sysopen(jsonfile))
    output_filename = Time.now.to_i.to_s + "_" + identity + "_results.json"
    new_filename = Time.now.to_i.to_s + "_result.json"
    File.open(output_filename, "w+").close
    File.open(new_filename, "w+").close
    identity_output = IO.open(IO.sysopen(output_filename, "w"), "w")
    data_output = IO.open(IO.sysopen(new_filename, "w"), "w")

    until input.eof?
      row = input.readline
      data = JSON.parse(row)
      if data["_p"] == identity
        identity_output.write(row)
        identity_output.write("\n")
      else
        data_output.write(row)
        data_output.write("\n")
      end
    end

    input.close
    File.delete(jsonfile)
  end
end