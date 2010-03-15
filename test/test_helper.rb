require "test/unit"
require "net/http"
require_relative "../lib/episode"
require_relative "../lib/brand"
require_relative "../lib/station"

class Net::HTTP
  def self.outside_uk(&block)
    @location = :international
    yield
  end

  def self.inside_uk(&block)
    @location = :uk
    yield
  end

  def self.location
    @location
  end

  FakeResponse = Struct.new(:code, :body)

  # Stub out the HTTP request response to return some known data.
  def request(request)
    if request.path == "/radio/aod/availability/radio4.xml"
      FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/r4_truncated.xml"))
    elsif request.path == "/mediaselector/4/mtis/stream/b00r0tfb"
      if Net::HTTP.location == :uk
        FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/media_selector_uk.xml"))
      else
        FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/media_selector_international.xml"))
      end
    elsif request.path == "/radio/listen/live/r4.asx"
      FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/r4.asx"))
    else
      FakeResponse.new("404", nil)
    end
  end
end
