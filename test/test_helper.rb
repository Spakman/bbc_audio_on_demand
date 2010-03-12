require "test/unit"
require "net/http"
require_relative "../lib/episode"
require_relative "../lib/brand"
require_relative "../lib/station"

class Net::HTTP
  FakeResponse = Struct.new(:code, :body)

  def request(request)
    if request.path == "/radio/aod/availability/radio4.xml"
      FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/r4_truncated.xml"))
    elsif request.path == "/mediaselector/4/mtis/stream/b00r0tfb"
      FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/b00r0tfb"))
    else
      FakeResponse.new("404", nil)
    end
  end
end
