require 'spec_helper'

describe "json_to_csv" do
  before do
    @testfilename = Time.now.to_i.to_s + "_test.json"
    testfile = File.open(@testfilename, "w+")
    json = JSON.pretty_generate(
      [
        {test: "test"},
        {test2: "test2"},
        {test3: "test3", test: "test3"},
        {test: "test"},
        {test2: "test2"},
        {test3: "test3", test: "test3"}
      ]
      )
    testfile.write(json)
    testfile.close
    KMExport.json_to_csv(@testfilename)
    @csv_files = Dir["*converter_result.csv"]
  end

  it "correctly converts JSON file to a CSV file" do
    @csv_files.length == 1
  end

  it "uses the correct CSV format" do
    csv = CSV.table(@csv_files.first)
    csv.headers.length.should eq 3
  end

  after do
    File.delete(@testfilename)
    File.delete(@csv_files.first)
  end
end