require 'spec_helper'

describe "alias_parser" do
  before :all do
    @aliasfilename = Time.now.to_i.to_s + "_test_alias.json"
    testfile = File.open(@aliasfilename, "w+")
    json = JSON.pretty_generate(
      [
        {_p2: "test", _p: "test1"},
        {test2: "test2"},
        {_p2: "test", _p: "test2"},
        {test: "test"},
        {_p2: "test", _p: "test3"},
        {test3: "test3", test: "test3"}
      ]
      )
    testfile.write(json)
    testfile.close
    KMExport.alias_parser(@aliasfilename)
  end

  it "removes aliases from JSON file" do
    file = File.open(@aliasfilename)
    json = JSON.parse(file.read)
    json.select { |row| row["_p2"] }.length.should eq 0
  end

  it "creates new JSON file with aliases" do
    file = File.open(Dir["*aliases.json"].first)
    json = JSON.parse(file.read)
    json.length.should eq 3
  end

  after :all do
    File.delete(@aliasfilename)
    File.delete(Dir["*aliases.json"].first)
  end
end