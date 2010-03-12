require "test/unit"
require "net/http"
require_relative "../lib/episode"
require_relative "../lib/brand"
require_relative "../lib/station"

class Net::HTTP
  FakeResponse = Struct.new(:code, :body)

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

  def request(request)
    if request.path == "/radio/aod/availability/radio4.xml"
      FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/r4_truncated.xml"))
    elsif request.path == "/mediaselector/4/mtis/stream/b00r0tfb"
      if Net::HTTP.location == :uk
        FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/media_selector_uk.xml"))
      else
        FakeResponse.new("200", File.read("#{File.dirname(__FILE__)}/data/media_selector_international.xml"))
      end
    else
      FakeResponse.new("404", nil)
    end
  end
end
