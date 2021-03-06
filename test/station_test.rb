require_relative "test_helper"

module BBCAudioOnDemand
  class StationTest < Test::Unit::TestCase
    def test_prepend_bbc_to_name
      assert_equal "BBC Radio 4", Station.new("Radio 4").name
    end

    def test_streaming_playlist_uri
      assert_equal "http://www.bbc.co.uk/radio/listen/live/r4.asx", Station.new("Radio 4").streaming_playlist_uri
    end

    def test_schedule_feed_uri
      assert_equal "http://www.bbc.co.uk/radio/aod/availability/radio4.xml", Station.new("Radio 4").schedule_feed_uri
    end

    def test_all_brands
      feed = File.read("#{File.dirname(__FILE__)}/data/r4.xml")
      station = Station.new("Radio 4", feed)
      assert_equal 20, station.all_brands.size
    end

    def test_available_brands
      feed = File.read("#{File.dirname(__FILE__)}/data/r4.xml")
      station = Station.new("Radio 4", feed)
      assert_equal 18, station.available_brands.size
    end

    def test_fetching_feed
      station = Station.new("Radio 4")
      assert station.fetch_and_parse_feed_if_required
      assert_equal 2, station.all_brands.size
    end

    def test_fetching_errored_feed
      station = Station.new("Radio 1")
      assert_raises(Net::HTTPServerException) { station.fetch_and_parse_feed_if_required }
    end

    def test_to_s
      station = Station.new("Radio 4")
      assert_equal station.name, station.to_s
    end
  end
end
