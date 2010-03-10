require "test/unit"
require_relative "../lib/episode"
require_relative "../lib/brand"
require_relative "../lib/station"

module BBCAudioOnDemand
  class EpisodeTest < Test::Unit::TestCase
    def setup
      feed = File.read("#{File.dirname(__FILE__)}/data/r4.xml")
      radio4 = Station.new("Radio 4", feed)
      @good_read = Brand.new("b006v8jn", radio4)
      @episode = Episode.new("b00r0tvf", @good_read)
    end

    def test_eql
      assert Episode.new(123).eql? Episode.new(123)
    end

    def test_hash
      assert_equal 123.hash, Episode.new(123).hash
    end

    def test_initialize_sets_attributes_correctly
      assert_equal @good_read, @episode.brand
      assert_equal "A Good Read, 02/03/2010", @episode.title
      assert_equal "Sue MacGregor talks to museum curator Ken Arnold and writer Jay Griffiths.", @episode.synopsis
      assert_equal 1800, @episode.duration
      assert_kind_of Time, @episode.start
      assert_kind_of Time, @episode.end
      assert_equal "http://www.bbc.co.uk/mediaselector/4/mtis/stream/b00r0tfb", @episode.media_selector_url
    end

    def test_available
      refute @episode.available?
      episode = Episode.new("b00qzrng", @good_read)
      assert episode.available?
    end

    def test_to_s
      assert_equal @episode.title, @episode.to_s
    end
  end
end
