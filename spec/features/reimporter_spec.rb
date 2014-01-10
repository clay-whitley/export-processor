require 'spec_helper'

describe "reimporter" do
  before do
    @reimporter = KMExport::Reimporter.new
    @json = JSON.pretty_generate(
      [
        {returning: "1", _p: "testuser", _t: 1384294380 },
        {referrer: "Direct", _p: "testuser", _t: 1384275438, _n: "visited site" },
        {_p2: "testuser2", _p: "testuser", _t: 1387799043 },
        {returning: "1", _p: "testuser1", _t: 1384294380 },
        {referrer: "Direct", _p: "testuser1", _t: 1384275438, _n: "visited site" },
        {_p2: "testuser2", _p: "testuser1", _t: 1387799043 }
      ]
      )

    @property_url = "http://trk.kissmetrics.com/s"
    @event_url = "http://trk.kissmetrics.com/e"
    @alias_url = "http://trk.kissmetrics.com/a"

    WebMock.disable_net_connect!

    stub_request(:get, @property_url).with(:query => hash_including({"returning" => "1"}))
    stub_request(:get, @event_url).with(:query => hash_including({"_n" => "visited site"}))
    stub_request(:get, @alias_url).with(:query => hash_including({"_n" => "testuser2"}))

    @reimporter.send_to_KM(@json, "1234")
  end

  it "succesfully sends a request for an event" do
    a_request(:get, @event_url).with(:query => hash_including({"_n" => "visited site"})).should have_been_made.times(2)
  end

  it "succesfully sends a request for a property" do
    a_request(:get, @property_url).with(:query => hash_including({"returning" => "1"})).should have_been_made.times(2)
  end

  it "succesfully sends a request for an alias" do
    a_request(:get, @alias_url).with(:query => hash_including({"_n" => "testuser2"})).should have_been_made.times(2)
  end
end