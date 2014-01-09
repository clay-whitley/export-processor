require 'spec_helper'
require 'pry'

describe "json_to_json" do
  before :all do
    @testfilename1 = Time.now.to_i.to_s + "_test.json"
    @testfilename2 = Time.now.to_i.to_s + "_test2.json"
    @testfilename3 = Time.now.to_i.to_s + "_test3.json"
    testfile = File.open(@testfilename1, "w+")
    testfile2 = File.open(@testfilename2, "w+")
    testfile3 = File.open(@testfilename3, "w+")
    json = JSON.generate({test: "test"})
    json2 = JSON.generate({test2: "test"})
    json3 = JSON.generate({test3: "test"})
    testfile.write(json)
    testfile2.write(json2)
    testfile3.write(json3)
    testfile.close
    testfile2.close
    testfile3.close
    KMExport.json_to_json
    @json_files = Dir["*result.json"]
  end

  it "creates one JSON file from many" do
    @json_files.length.should eq 1
  end

  it "creates a JSON file that contains the combined data" do
    file = File.open(@json_files.first)
    json = JSON.parse(file.read)
    json.include?({"test" => "test"}) && json.include?({"test3" => "test"})
  end

  after :all do
    File.delete(@testfilename1)
    File.delete(@testfilename2)
    File.delete(@testfilename3)
    File.delete(@json_files.first)
  end
end